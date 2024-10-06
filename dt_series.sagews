# Definizione della funzione S_j
def S_j(x, j):
    if x % (2*j) < j:
        return +1
    else:
        return -1

# Generazione della matrice S
def gen_S_matrix(n):
    columns = []
    for j in range(1, n+1):
        column_vector = vector(ZZ, [S_j(x, j) for x in range(0, n)])
        columns.append(column_vector)

    S = column_matrix(columns)
    return S

# Generazione e plot della matrice S
def gen_S_and_show(n):
    S = gen_S_matrix(n)
    show(S)
    print("det(S) =", S.det())
    return S

# Generazione del dominio dei naturali a partire dall'immagine della funzione
def gen_domain(image):
    domain = []
    m = len(image)
    for i in range(m):
        domain.append(i)
    return domain

# Generazione della funzione
def fun(x):
    if x < len(domain):
        return image[x]

# Generazione e plot della funzione
def gen_fun_and_plot(image):
    domain = gen_domain(image)
    points = [(x, image[x]) for x in domain]
    p = list_plot(points, plotjoined=True, marker='o', legend_label='f(x)')
    p.show(axes_labels=["x", "f(x)"])
    return domain

# Utilizzo della serie per ricostruire la funzione
def reconstruct_f(x, amplitudes):
    f_x = 0
    for i, a_i in enumerate(amplitudes):
        j = i + 1
        f_x += a_i * S_j(x, j)
    return f_x

# Stampa delle ampiezze con le relative frequenze
def print_amplitudes(amplitudes):
    print("\nFrequenze e ampiezze:")
    for i in range(len(amplitudes)):
        freq = 1 / (2 * (i + 1))
        print(f"freq: {freq}, amp: {amplitudes[i]}")
        
        
####################### Utilizzo ####################### 

# Inserire l'immagine della funzione 
image = [1, 2, 3]

n = len(image)
domain = gen_fun_and_plot(image)

# Costruzione di S
S = gen_S_and_show(n)

# Calcolo delle ampiezze
amplitudes = S.solve_right(vector(image))
print("Ampiezze trovate: ", amplitudes)
reconstructed_values = [reconstruct_f(x, amplitudes) for x in domain]
                           
# Qua dovremmo ottenere l'immagine di origine "image"
print("Funzione ricostruita: ", reconstructed_values)
