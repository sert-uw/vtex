echo "Tex Error\n\n" > errors/error.err
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n" >> errors/error.err

rm document.pdf
rm ./images/*.xbb

extractbb ./images/*.png
extractbb ./images/*.jpg

platex -kanji=utf8 -halt-on-error -interaction=nonstopmode -file-line-error document.tex >> errors/error.err
platex -kanji=utf8 -halt-on-error -interaction=nonstopmode -file-line-error document.tex
dvipdfmx -f ptex-ipa.map document.dvi

rm *.log *.lot *.lof *.aux *.toc *.dvi
