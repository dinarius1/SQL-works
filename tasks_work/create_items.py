import random
import csv

# Создаем функцию, которая записывает полученные данные в файл "items.csv"
def write_csv(data):
    with open('items.csv', 'a', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['price'])  # Добавляем заголовок для столбца
        for row in data:
            writer.writerow([row])  # Представляем наши данные в виде списка с одним элементом

# Создаем функцию, которая образует данные необходимые для заполнения таблицы Items
def data_func(num_items):
    data = []
    for i in range(1, num_items + 1):
        # Генерируем случайные цены от 100 до 1000
        price = random.randint(100, 1000)
        data.append(price) 
    # Вызываем функцию по записи полученных данных в csv файл
    write_csv(data)
    return data

# Указываем сколько хотим, чтобы было items (продуктов)
items = 100
# Вызываем главную функцию по генерацию данных для бд
data_func(items)


