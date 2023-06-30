import random
import csv

#Создаем функцию, которая записывает полученные данные в файл user.csv
def write_csv(data):
    with open('user.csv', 'a', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['age'])  #Добавляем заголовок для столбца
        for row in data:
            writer.writerow([row]) 

#Создаем функцию, которая образует данные необходимые для заполнения бд
def data_func(num_users):
    data = []
    for i in range(1, num_users + 1):
        #Генерируем случайные возраста от 18 до 90
        age = random.randint(18, 90)  
        data.append(age) 
    #Вызываем функцию по записи полученных данных в csv файл
    write_csv(data)
    return data

#Указываем сколько хотим, чтобы было пользователей
users = 100
#Вызываем главную функцию по генерацию данных для бд
data_func(users)


