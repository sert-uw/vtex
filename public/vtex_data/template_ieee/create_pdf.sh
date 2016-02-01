echo "Tex Error\n\n" > errors/error.err
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n" >> errors/error.err

rm document.pdf
rm ./images/*.xbb

extractbb ./images/*.png
extractbb ./images/*.jpg

platex -halt-on-error -interaction=nonstopmode -file-line-error document.tex >> errors/error.err
platex -halt-on-error -interaction=nonstopmode -file-line-error document.tex

dvipdfmx -f dvipdfm_dl14.map document.dvi

rm *.log *.lot *.lof *.aux *.toc *.dvi
