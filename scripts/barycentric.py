import numpy as np
from stl import mesh


def get_mid(pt1: np.array, pt2:np.array) -> np.array:


    return (pt1+pt2)/2


def get_vertices():
    
    bottom_tri = np.array([[0, 0, 0],
                           [1, 0, 0],
                           [0.5, np.sqrt(3)/2, 0]])

    top_tri = np.array([[0, 0, 1],
                        [1, 0, 1],
                        [0.5, np.sqrt(3)/2, 1]])
    barycenter = np.sum(top_tri, axis=0) / 3
    mid1 = get_mid(top_tri[0], top_tri[1])
    mid2 = get_mid(top_tri[1], top_tri[2])
    mid3 = get_mid(top_tri[2], top_tri[0])


    vertex_array = np.vstack([bottom_tri, top_tri, barycenter, mid1, mid2, mid3])
    
    for i in range(vertex_array.shape[0]):
        print(f'{i}\t{vertex_array[i]}')
    # print(f'vertices: {vertices}')
    # print(f'vertices shape: {vertices.shape}')
    
    return vertex_array


def make_stl(vertex_array: np.array, shape, how: str='one'):
    
    if how == 'one':
        # create mesh and then STL file
        simplex = mesh.Mesh(np.zeros(shape.shape[0], dtype=mesh.Mesh.dtype))
        for i, f in enumerate(shape):
            for j in range(3):
                simplex.vectors[i][j] = vertex_array[f[j],:]

        simplex.save('barycentric.stl')

    elif how =='many':
        for k, tetra in enumerate(shape):
            # create mesh and then STL file
            stl_tetra = mesh.Mesh(np.zeros(tetra.shape[0], dtype=mesh.Mesh.dtype))
            for i, f in enumerate(tetra):
                for j in range(3):
                    stl_tetra.vectors[i][j] = vertex_array[f[j],:]

            stl_tetra.save(f'tetra{k}.stl')




if __name__ == '__main__':
    
    vertices = get_vertices()

    # we should have 10 total tetrahedra
    tetra0 = np.array([[3,6,7],
                       [0,3,7],
                       [0,3,6],
                       [0,6,7]], dtype=int)
    tetra1 = np.array([[3,9,6],
                       [0,3,9],
                       [0,9,6],
                       [0,3,6]], dtype=int)
    tetra2 = np.array([[5,6,9],
                       [2,5,9],
                       [2,6,9],
                       [2,5,6]], dtype=int)
    tetra3 = np.array([[5,6,8],
                       [2,5,6],
                       [2,6,8],
                       [2,5,8]], dtype=int)
    tetra4 = np.array([[4,6,8],
                       [1,4,6],
                       [1,6,8],
                       [1,4,8]], dtype=int)
    tetra5 = np.array([[4,7,6],
                       [1,4,7],
                       [1,7,6],
                       [1,4,6]], dtype=int)
    # weird side tetrahedra
    tetra6 = np.array([[0,1,7],
                       [0,7,6],
                       [1,7,6],
                       [0,1,6]], dtype=int)
    tetra7 = np.array([[1,2,8],
                       [2,6,8],
                       [1,6,8],
                       [1,2,6]], dtype=int)
    tetra8 = np.array([[0,2,9],
                       [0,9,6],
                       [2,9,6],
                       [0,2,6]], dtype=int)
    # bottom tetrahedron
    tetra9 = np.array([[0,1,2],
                       [0,1,6],
                       [0,2,6],
                       [1,2,6]], dtype=int)

    # combine all the tetrahedra to form triangular cylinder
    all_tetra = [tetra0, tetra1, tetra2, tetra3, tetra4, tetra5, tetra6, tetra7, tetra8, tetra9]
    total_tetra = np.vstack(all_tetra)

    # create mesh and then STL file
    make_stl(vertices, all_tetra, how='many')
    make_stl(vertices, total_tetra, how='one')

