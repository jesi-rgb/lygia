/*
original_author: Matt DesLauriers
description: adapted versions of gaussian fast blur 13 from https://github.com/Jam3/glsl-fast-gaussian-blur
use: gaussianBlur1D_fast5(<sampler2D> texture, <vec2> st, <vec2> pixel_direction)
options:
    - SAMPLER_FNC(TEX, UV): optional depending the target version of GLSL (texture2D(...) or texture(...))
    - GAUSSIANBLUR1D_FAST5_TYPE
    - GAUSSIANBLUR1D_FAST5_SAMPLER_FNC(POS_UV)
*/

#ifndef SAMPLER_FNC
#define SAMPLER_FNC(TEX, UV) texture2D(TEX, UV)
#endif

#ifndef GAUSSIANBLUR1D_FAST5_TYPE
#ifdef GAUSSIANBLUR_TYPE
#define GAUSSIANBLUR1D_FAST5_TYPE GAUSSIANBLUR_TYPE
#else
#define GAUSSIANBLUR1D_FAST5_TYPE vec4
#endif
#endif

#ifndef GAUSSIANBLUR1D_FAST5_SAMPLER_FNC
#ifdef GAUSSIANBLUR_SAMPLER_FNC
#define GAUSSIANBLUR1D_FAST5_SAMPLER_FNC(POS_UV) GAUSSIANBLUR_SAMPLER_FNC(POS_UV)
#else
#define GAUSSIANBLUR1D_FAST5_SAMPLER_FNC(POS_UV) SAMPLER_FNC(tex, POS_UV)
#endif
#endif

#ifndef FNC_GAUSSIANBLUR1D_FAST5
#define FNC_GAUSSIANBLUR1D_FAST5
GAUSSIANBLUR1D_FAST5_TYPE gaussianBlur1D_fast5(in sampler2D tex, in vec2 st, in vec2 offset) {
    GAUSSIANBLUR1D_FAST5_TYPE color = GAUSSIANBLUR1D_FAST5_TYPE(0.);
    vec2 off1 = vec2(1.3333333333333333) * offset;
    color += GAUSSIANBLUR1D_FAST5_SAMPLER_FNC(st) * .29411764705882354;
    color += GAUSSIANBLUR1D_FAST5_SAMPLER_FNC(st + (off1)) * .35294117647058826;
    color += GAUSSIANBLUR1D_FAST5_SAMPLER_FNC(st - (off1)) * .35294117647058826;
    return color;
}
#endif
