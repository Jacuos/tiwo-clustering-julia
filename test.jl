using Clustering

I = [1, 4, 3, 5];
using Clustering

# make a random dataset with 1000 points
# each point is a 5-dimensional vector
X = rand(5, 1000)

# performs K-means over X, trying to group them into 20 clusters
# set maximum number of iterations to 200
# set display to :iter, so it shows progressive info at each iteration
R = kmeans(X, 20; maxiter=200, display=:iter)

# the number of resultant clusters should be 20
@assert nclusters(R) == 20

# obtain the resultant assignments
# a[i] indicates which cluster the i-th sample is assigned to
a = assignments(R)

# obtain the number of samples in each cluster
# c[k] is the number of samples assigned to the k-th cluster
c = counts(R)

# get the centers (i.e. mean vectors)
# M is a matrix of size (5, 20)
# M[:,k] is the mean vector of the k-th cluster
M = R.centers
