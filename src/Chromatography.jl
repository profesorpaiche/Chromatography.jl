module Chromatography

export colorFrequency, extractColors

using StatsBase
using FixedPointNumbers
using Colors
using OrderedCollections

# Count the number of pixels for each color
function colorFrequency(img::Matrix{RGB{N0f8}})
    freq = countmap(img)
    freq = sort(freq, byvalue = true, rev = true)
    return freq
end

# Color difference
function colorDiff(colors::Vector{RGB{N0f8}})
    rgb1 = convert.(Float64, [colors[1].r, colors[1].g, colors[1].b])
    rgb2 = convert.(Float64, [colors[2].r, colors[2].g, colors[2].b])
    rgb_diff = abs.(rgb1 - rgb2)
    rgb_diff = mean(rgb_diff)
    return rgb_diff
end

# Select N different colors
function extractColors(colors::Vector{RGB{N0f8}}, n::Integer; tolerance::Float64 = 0.1)
    main_colors = RGB{N0f8}[]
    push!(main_colors, colors[1])

    for ic in eachindex(colors)
        n_mc = length(main_colors)
        # The less different color is:
        color_diff_tmp = [colorDiff([main_colors[imc], colors[ic]])[1] for imc in 1:n_mc]
        color_diff = minimum(color_diff_tmp)

        if color_diff > tolerance; push!(main_colors, colors[ic]); end
        if length(main_colors) == n; break; end
    end

    return main_colors
end

function extractColors(colors::OrderedDict{RGB{N0f8}, Int64}, n::Integer; tolerance::Float64 = 0.1)
    colors_rgb = keys(colors) |> collect
    extractColors(colors_rgb, n; tolerance = tolerance)
end

end
