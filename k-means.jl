using Clustering
using Gadfly

m = [[1.0 2.0 7.0 7.0 10.0 12.0 12.0 18.0 19.0 20.0];[2.0 1.0 10.0 15.0 12.0 10.0 15.0 16.0 14.0 16.0]]

#=Testujemy na idealnych centroid=#
exp = [[1.5 9.6 19.0];[1.5 12.4 15.3333]]
R = kmeans!(m, exp; maxiter=100, display=:iter)
@assert nclusters(R) == 3
as = assignments(R)
@assert as == [1; 1; 2; 2; 2; 2; 2; 3; 3; 3;]
centr = R.centers
@assert centr == exp
println(as)
println(centr)


#=Wykres poglądowy - zrobiony nieco na sztywno, biblioteka Gadfly niestety jest nieco ograniczona=#
col = ["blue" "green" "black"]
l1 = layer(x=m[1,1:2], y=m[2,1:2],Geom.point,Theme(default_color=color("blue")))
l2 = layer(x=m[1,3:7], y=m[2,3:7],Geom.point,Theme(default_color=color("green")))
l3 = layer(x=m[1,8:10], y=m[2,8:10],Geom.point,Theme(default_color=color("black")))
p = plot(l1,l2,l3,layer(x=centr[1, : ], y=centr[2, : ],Geom.point,Theme(default_color=color("red"))))

#=Testujemy dla losowych centroid =#
R = kmeans(m, 3; maxiter=100, display=:iter)
@assert nclusters(R) == 3
as = assignments(R)
centr = R.centers
println(as)
println(centr)

#=Testujemy dla błędnych centroid=#
exp = [[0.0 0.0 0.0];[0.0 0.0 0.0]]
R = kmeans!(m, exp; maxiter=100, display=:iter)
@assert nclusters(R) == 3
as = assignments(R)
centr = R.centers
println(as)
println(centr)

display(p)
