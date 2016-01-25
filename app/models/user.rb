class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:number]

  after_create :create_directory

  has_many :projects, dependent: :destroy

  validates_uniqueness_of :number
  validates_presence_of :number

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["number = :value", { value: number }]).first
    else
      where(conditions).first
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  private

  def create_directory
    system("mkdir #{Rails.root}/public/vtex_data/#{self.number}")
  end
end
