# convert without wrapping
pandoc -f latex -t markdown -o index.qmd --wrap=none main.tex  
# remove double brackets
# sed -E -i "s|\(\[(.+)\]\)|[\1]|g" index.qmd
sed -E -i "s|\(\[|[|g" index.qmd
sed -E -i "s|\]\)|]|g" index.qmd


# include references
sed -i "1i\
---\n\
bibliography: references.bib\n\
---" index.qmd

# replace fig: with fig-
sed -E -i 's|"fig:(.+)"|"fig-\1"|g'   index.qmd
sed -E -i 's|\(#fig:(.+)\)|(#fig-\1)|g'   index.qmd


# replace <figure> with :::
sed -E -i 's|<figure id="([^"]+)">|:::{#\1}|g' index.qmd
sed -E -i 's|</figure>|:::|g' index.qmd


sed -z -E -i 's|<img src="([^"]+)"[^>]*>|![](\1)\n|g' index.qmd

sed -E -i 's|</?figcaption>||g' index.qmd

# replace references
sed -E -i 's|Figure \[[0-9]+\]\(#(fig-[^}]+)\)\{[^}]+\}|@\1|g' index.qmd
