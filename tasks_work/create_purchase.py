import random
from datetime import date, timedelta
import csv

# Создаем функцию, которая записывает полученные данные в файл "purchase.csv"
def write_csv(list1):
    with open('purchase.csv', 'a', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['userid', 'itemid', 'date'])  # Записываем заголовки для столбцов
        for row in list1:
            writer.writerow(row)

# Создаем функцию, которая генерирует случайные даты в заданном диапазоне и создает список данных. 
def generate_random_date(start_date, end_date, num_date):
    # Меняем формат аргументов со строки на формат дат с помощью функции date.fromisoformat(). Полученные данные сохраняем в переменные.
    start_date = date.fromisoformat(start_date)
    end_date = date.fromisoformat(end_date)

    # Создаем переменную формата timedelta для вычисления интервала между датами.
    date_range = end_date - start_date
    list1 = []
    for i in range(num_date):
        # Генерируем случайные id пользователей
        userid = random.randint(1, 100)
        # Генерируем случайные id товаров
        itemid = random.randint(1, 100)
        # Генерируем случайные даты
        random_days = random.randint(0, date_range.days)
        random_date = start_date + timedelta(days=random_days)
        list1.append([userid, itemid, random_date])

    # Вызываем функцию по записи полученных данных в csv файл
    write_csv(list1)
    return list1

# Указываем начальную дату и конечную
start_date = "2023-01-01"
end_date = "2023-12-31"

# Вызываем главную функцию по генерацию данных для бд
generate_random_date(start_date, end_date, 100)
