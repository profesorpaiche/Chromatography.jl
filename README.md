# Chromatography

`Chromatography` allows one to extract the most frequent colors from any image
you provide. As simple as that.

## Installation

Inside the Julia shell, you can install the package by running:

```
using Pkg
Pkg.add(url = "https://github.com/profesorpaiche/Chromatography.jl")
```

## Example

Here is a simple example with a ![random image from IKEA](https://www.ikea.com/ca/en/images/products/mala-chalk-mixed-colors__1085507_pe860123_s5.jpg).
You can download the image from the terminal with:

```
wget https://www.ikea.com/ca/en/images/products/mala-chalk-mixed-colors__1085507_pe860123_s5.jpg -O chalk.jpg
```

And with Julia, let's extract and visualize the 9 more frequent colors.

```
using Chromatography
using FileIO
using Images
using ImageView

img = load("chalk.jpg")
colors = colorFrequency(img)
main_colors = extractColors(colors, 9)
imshow(reshape(main_colors, (3, 3)))
```
