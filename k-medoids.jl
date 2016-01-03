using Distances
using Gadfly

X = [[1.0 2.0 7.0 7.0 10.0 12.0 12.0 18.0 19.0 20.0];[2.0 1.0 10.0 15.0 12.0 10.0 15.0 16.0 14.0 16.0]]
Y = X
println(Y)
C = pairwise(Euclidean(), X, Y)

#=Testujemy na dosyć dobrych medoid=#
med = [2; 5; 9;]
R = kmedoids!(C, med; maxiter=100, display=:iter)
@assert nclusters(R) == 3
as = assignments(R)
@assert as == [1; 1; 2; 2; 2; 2; 2; 3; 3; 3;]
centr = R.medoids
@assert centr == med
println(as)
println(centr)


medX = [X[1,centr[1]] X[1,centr[2]] X[1,centr[3]]]
medY = [X[2,centr[1]] X[2,centr[2]] X[2,centr[3]]]

col = ["blue" "green" "black"]
l1 = layer(x=X[1,1:2], y=X[2,1:2],Geom.point,Theme(default_color=color("blue")))
l2 = layer(x=X[1,3:7], y=X[2,3:7],Geom.point,Theme(default_color=color("green")))
l3 = layer(x=X[1,8:10], y=X[2,8:10],Geom.point,Theme(default_color=color("black")))
l4 = layer(x=medX, y=medY,Geom.boxplot)

p = plot(l1,l2,l3,l4)

#=Testujemy dla losowych medoid =#
R = kmedoids(C, 3; maxiter=100, display=:iter)
@assert nclusters(R) == 3
as = assignments(R)
centr = R.medoids
println(as)
println(centr)


#=Testujemy dla błędnych medoid=#
med = [8; 9; 10;]
R = kmedoids!(C, med; maxiter=100, display=:iter)
@assert nclusters(R) == 3
as = assignments(R)
@assert as == [2; 2; 1; 1; 1; 1; 1; 3; 3; 3;]
centr = R.medoids
@assert centr == [5,1,8]
println(as)
println(centr)



#=Testujemy na dosyć dobrych medoid i innego sposobu liczenia odległości=#
C = pairwise(Cityblock(), X, Y)

med = [2; 5; 9;]
R = kmedoids!(C, med; maxiter=100, display=:iter)
@assert nclusters(R) == 3
as = assignments(R)
@assert as == [1; 1; 2; 2; 2; 2; 2; 3; 3; 3;]
centr = R.medoids
@assert centr == med
println(as)
println(centr)






display(p)
