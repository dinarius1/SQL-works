import csv
import psycopg

# Создаем функцию по импортированию данных в PostresSQL
def load_data_from_csv():
    # Указываем данные бд, чтобы к ней полдключиться
    conn = psycopg.connect(
        host="localhost",
        port="5432",
        dbname="work_db",
        user="user",
        password="1"
    )
    cursor = conn.cursor()
    
    # Читаем файл с данными и затем загружаем эти данные в нашу бд
    with open('items.csv', 'r', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)  # Пропускаем заголовки столбцов

        for row in reader:
            price = row[0]
            cursor.execute(
                "INSERT INTO Items (price) VALUES (CAST(%s AS money))",
                (price,)
            )

    conn.commit()
    cursor.close()
    conn.close()

# Вызывем главную функцию по импортированию данных в PostresSQL
load_data_from_csv()
