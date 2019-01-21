# DynamicModeDecomposition
Dimensionality Reduction technique similar to PCA without an orthogonality constraint. 

Today we're going to build a DMD model that models a dynamic systems underlying structure.  It is similar to PCA however it has no
orthogonality constraint, meaning it groups signals of varying frequencies togeth (eg. 20hz and 50hz).  This allows us to better pull
out individual components of a signal (think like pulling out blue and red paint from purple).  

While PCA gives us the most important features of what it means to be purple, DMD will give us what it believes the most important
individual components (or frequencies) to create purple (ie. red + blue).  I will demonstrate this in Matlab by combining Secant
and Tangent signals of varying phases.  We will then compare how DMD and PCA pull the signals apart respectively:

