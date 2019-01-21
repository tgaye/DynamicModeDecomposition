# DynamicModeDecomposition
Dimensionality Reduction technique similar to PCA without an orthogonality constraint.  Signal Processing.
Based on this original paper, 2008: https://hal-polytechnique.archives-ouvertes.fr/hal-01020654/document

Today we're going to build a DMD model that models a dynamic systems underlying structure.  It is similar to PCA however it has no
orthogonality constraint, meaning it groups signals of varying frequencies togeth (eg. 20hz and 50hz).  This allows us to better pull
out individual components of a signal (think like pulling out blue and red paint from purple).  

This has applications in a wide range of fields in signal processing, audio processing, medical timeseries data, stock forecasting, any timeseries with various frequency components.  Similar to Fourier Transforms and Wavelet Transforms, but non parametric.

While PCA gives us the most important features of what it means to be purple, DMD will give us what it believes the most important
individual components (or frequencies) to create purple (ie. red + blue).  I will demonstrate this in Matlab by combining Secant
and Tangent signals of varying phases.  We will then compare how DMD and PCA pull the signals apart respectively:

# Plot our two distinct signals and their combination:
![fig00](https://user-images.githubusercontent.com/34739163/51447041-1527ff80-1cd7-11e9-832a-651dfeb4ca22.png)

Now we use PCA to filter the Low Rank Features of our data (in this case we want the model to return 2, for the Sec and Tan signals)
![fig02](https://user-images.githubusercontent.com/34739163/51447015-c2e6de80-1cd6-11e9-9e36-e29fbd2f92c8.png)

We can see PCA found 2 features that explain nearly 100% of the variablitiy in the data (1 red dot at 60, 1 at 40)
Now lets plot these 2 Low Rank Features and see if we isolated the Tan and Sec signals properly.

# Plot PCA features:
![fig03](https://user-images.githubusercontent.com/34739163/51447016-c4180b80-1cd6-11e9-8b82-cae88aa1214a.png)

Neither of these functions are our Sech or Tan signals, however it has discovered features that explain the combination of the 2 well enough to reconstruct the combination, just not the individual components.  Lets see if DMD can help us get the red and blue from the purple.

# Plot DMD features:
![fig04](https://user-images.githubusercontent.com/34739163/51447017-c5e1cf00-1cd6-11e9-862a-fe747f440010.png)

We can see DMD has managed to completely isolate our original component input signals.  Finally lets compare our models forecast of the 2 signals to the actual target signal:

# Compare Model forecast to target:
![fig01](https://user-images.githubusercontent.com/34739163/51447013-bd899400-1cd6-11e9-8c15-a75380dace8b.png)
