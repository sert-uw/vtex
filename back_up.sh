rm -r /home/samba/public/vtex_backup/*
cp -r /home/hiraoka/rails_project/vtex/public/vtex_data/* /home/samba/public/vtex_backup/
cd /home/samba/public/vtex_backup/

D=`date '+%Y-%m-%d_%H'`

git add .
git commit --allow-empty -m "${D}"
