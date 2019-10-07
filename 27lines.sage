var('x','y','z')

# implicit eqn of Clebsch surf
s = 81*(x^3 + y^3 + z^3) - 189*(x^2*y + x*y^2 + x^2*z + x*z^2 + y^2*z + y*z^2) + 54*(x*y*z) + 126*(x*y + x*z + y*z) - 9*(x^2 + y^2 + z^2) - 9*(x + y + z) + 1

# parametric forms of the 27 lines.
# Each entry on the list is a list of 6 numbers, [a,b,c,d,e,f],
# this corresponds to the line through (a,b,c) with direction vector <d,e,f>
# it's a kludge.
linedata = [[0,0,-1/3,1,-1,0],
            [0,-1/3,0,1,0,-1],
            [-1/3,0,0,0,1,-1],
            [1/6,1/6,0,1,-1,0],
            [1/3,1/3,1/3,1,-1,0],
            [1/6,0,1/6,1,0,-1],
            [1/3,1/3,1/3,1,0,-1],
            [0,1/6,1/6,0,1,-1],
            [1/3,1/3,1/3,0,1,-1],
            [1/6,0,1/6,3,0,1],
            [1/6,1/6,0,3,1,0],
            [0,1/6,1/6,0,3,1],
            [1/6,0,1/6,1,0,3],
            [1/6,1/6,0,1,3,0],
            [0,1/6,1/6,0,1,3],
            map(n,[(5+sqrt(5))/30,(5+3*sqrt(5))/30,0,1+3/sqrt(5), -1/sqrt(5),1]),
            map(n,[(5+3*sqrt(5))/30, (5+sqrt(5))/30,0,-1/sqrt(5), 1+3/sqrt(5),1]),
            map(n,[(7+3*sqrt(5))/6,(3+sqrt(5))/6,0,-3-sqrt(5), -sqrt(5),1]),
            map(n,[(3+sqrt(5))/12,(1-sqrt(5))/12,0,(-3+sqrt(5))/4,(-5+3*sqrt(5))/4,1]),
            map(n,[(1+sqrt(5))/12,(3-sqrt(5))/12,0,(-5-3*sqrt(5))/4,(-3-sqrt(5))/4,1]),
            map(n,[(3-sqrt(5))/6,(7-3*sqrt(5))/6,0,sqrt(5),-3+sqrt(5),1]),
            map(n,[(3+sqrt(5))/6,(7+3*sqrt(5))/6,0,-sqrt(5),-3-sqrt(5),1]),
            map(n,[(1-sqrt(5))/12,(3+sqrt(5))/12,0,(-5+3*sqrt(5))/4,(-3+sqrt(5))/4,1]),
            map(n,[(3-sqrt(5))/12,(1+sqrt(5))/12,0,(-3-sqrt(5))/4,(-5-3*sqrt(5))/4,1]),
            map(n,[(7-3*sqrt(5))/6,(3-sqrt(5))/6,0,-3+sqrt(5),sqrt(5),1]),
            map(n,[(5-sqrt(5))/30,(5-3*sqrt(5))/30,0,1-3/sqrt(5), 1/sqrt(5),1]),
            map(n,[(5-3*sqrt(5))/30, (5-sqrt(5))/30,0,1/sqrt(5), 1-3/sqrt(5),1])]
            

# distance from (x,y,z) to line l_i (for i from 0 to 27)
def dl(i,x,y,z):
    [a,b,c,d,e,f] = linedata[i]
    s = (d*(x-a)+e*(y-b)+f*(z-c))/(d^2+e^2+f^2)
    return sqrt(((x-a) - s*d)^2 + ((y-b) - s*e)^2 + ((z-c) - s*f)^2)

# region function
def rf(x,y,z):
    dist = x^2 + y^2 + z^2
    mindl = min([dl(i,x,y,z) for i in [0..26]])
    return (dist < 2) and (1 < dist or mindl < 0.025)

# size of bounding box
bd = 2

# level of detail (500 = good but slow, 100 = bad but fast)
p = 200

def lines():
    return implicit_plot3d(s,(x,-bd,bd),(y,-bd,bd),(z,-bd,bd),region=rf,plot_points=p,smooth=True)

