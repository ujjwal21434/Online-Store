import mysql.connector


db = mysql.connector.connect(
  host="localhost",
  user="root",
  password="root",
  database="onlinestore5"
)



# OLAP queries
query3="SELECT Category.category_name, Product.brand, SUM(Product.MRP * Product.quantity) AS total_sales FROM Product INNER JOIN Category ON Product.category_id = Category.category_id GROUP BY Category.category_name, Product.brand WITH ROLLUP;"
query4="SELECT YEAR(order_placed.order_date) AS year, MONTH(order_placed.order_date) AS month, SUM(order_placed.total_amount) AS total_sales FROM order_placed GROUP BY YEAR(order_placed.order_date), MONTH(order_placed.order_date) WITH ROLLUP;"
query5="SELECT IFNULL(order_status, 'Total') AS order_status, COUNT(*) AS order_coun FROM order_placed GROUP BY order_status WITH ROLLUP HAVING order_status IS NOT NULL;"
query6="SELECT IFNULL(created_year, 'Total') AS created_year, COUNT(*) AS total_customers FROM (SELECT YEAR(created_at) AS created_year FROM Customer) AS year GROUP BY created_year WITH ROLLUP HAVING created_year IS NOT NULL;"

#triggers 
q7="DELIMITER $$ CREATE TRIGGER prevent_duplicate_phone_numbers BEFORE INSERT ON Customer FOR EACH ROW BEGIN DECLARE phone_count INT; SELECT COUNT(*) INTO phone_count FROM Customer WHERE phone_number = NEW.phone_number; IF phone_count > 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phone number already exists in the Customer table'; END IF; END$$ DELIMITER $$ "
q8="INSERT INTO `Customer` (`customer_id`, `first_name`, `middle_name`, `last_name`, `email`, `password`, `address`, `phone_number`, `created_at`) VALUES (15, 'rit', '', 'kirar', 'isdcfds@example.com', 'e7fa8cf', '37199 Suber Cie, AK 31169-3278', 9873214560, '2007-03-10 12:50:14');"
q9="DELIMITER $$ CREATE TRIGGER update_product_quantity AFTER INSERT ON order_placed FOR EACH ROW BEGIN UPDATE Product SET quantity = quantity - 1 WHERE Product.product_id =new.product_id; END$$ DELIMITER $$`"
q10="INSERT INTO `order_placed` (`order_id`, `total_amount`, `order_status`, `order_date`, `customer_id`, `product_id`) VALUES (12, '99999999.99', 'Delivered', '1989-09-24 05:28:22', 1, 1);"

def execute_query(query):
    mycursor = db.cursor()
    mycursor.execute(query)
    #mydb.commit()
    result = mycursor.fetchall()
    for row in result:
        print(row)




def signup():
    print("Customer Signup")
    first_name = input("First Name: ")
    middle_name = input("Middle Name (Optional): ")
    last_name = input("Last Name: ")
    email = input("Email: ")
    password = input("Password: ")
    address = input("Address: ")
    phone_number = input("Phone Number: ")
    
    cursor = db.cursor()
    sql = "INSERT INTO Customer (first_name, middle_name, last_name, email, password, address, phone_number) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (first_name, middle_name, last_name, email, password, address, phone_number)
    cursor.execute(sql, values)
    db.commit()
    
    print("Customer has been signed up successfully.")


def login():
    print("Customer Login")
    email = input("Email: ")
    password = input("Password: ")
    
    cursor = db.cursor()
    sql = "SELECT * FROM Customer WHERE email = %s AND password = %s"
    values = (email, password)
    cursor.execute(sql, values)
    customer = cursor.fetchone()
    
    if customer is not None:
        print("Login successful.")
        return customer[0] 
    else:
        print("Invalid email or password.")
        return None


def admin_login():
    print("admin Login")
    email = input("Email: ")
    password = input("Password: ")
    
    cursor = db.cursor()
    sql = "SELECT * FROM Admin WHERE email = %s AND password = %s"
    values = (email, password)
    cursor.execute(sql, values)
    admin = cursor.fetchone()
    
    if admin is not None:
        print("Admin Login successful.")
        return admin[0] 
    else:
        print("Invalid email or password.")
        return None


def view_products():
    print("Available Products")
    cursor = db.cursor()
    cursor.execute("SELECT * FROM Product")
    products = cursor.fetchall()
    for product in products:
        print(product)


def view_cart(user_id):
    print("Your Cart")
    cursor = db.cursor()
    sql = "SELECT * FROM Cart INNER JOIN Product ON Cart.product_id = Product.product_id WHERE Cart.customer_id = %s"
    values = (user_id,)
    cursor.execute(sql, values)
    cart_items = cursor.fetchall()
    for cart_item in cart_items:
        print(cart_item)


def add_to_cart(user_id):
    print("Add to Cart")
    product_id = input("Enter the product ID to add to cart: ")
    quantity = input("Enter the quantity: ")
    cursor = db.cursor()
    sql = "INSERT INTO Cart (customer_id, product_id, quantity) VALUES (%s, %s, %s)"
    values = (user_id, product_id, quantity)
    cursor.execute(sql, values)
    db.commit()
    print("Product has been added to cart.")

def user_menu(user_id):
    while True:
        print("\nUser Menu")
        print("1. View Products")
        print("2. View Cart")
        print("3. Add to Cart")
        print("4. Remove from Cart")
        print("5. Place Order")
        print("6. Logout")

        choice = input("\nEnter your choice: ")

        if choice == '1':
            view_products()
        elif choice == '2':
            view_cart(user_id)
        elif choice == '3':
            add_to_cart(user_id)
        elif choice == '4':
            remove_from_cart(user_id)
        elif choice == '5':
            place_order(user_id)
        elif choice == '6':
            logout()
            break
        else:
            print("\nInvalid choice. Please try again.")


def remove_from_cart(user_id):
    print("Remove from Cart")
    product_id = input("Enter the product ID to remove from cart: ")
    cursor = db.cursor()
    sql = "DELETE FROM Cart WHERE customer_id = %s AND product_id = %s"
    values = (user_id, product_id)
    cursor.execute(sql, values)
    db.commit()
    print("Product has been removed from cart.")


def place_order(user_id):
    print("Place Order")
    cursor = db.cursor()
    sql = "SELECT * FROM Cart WHERE customer_id = %s"
    values = (user_id,)
    cursor.execute(sql, values)
    cart_items = cursor.fetchall()

    if len(cart_items) == 0:
        print("Your cart is empty.")
        return

    total_amount = 0
    for cart_item in cart_items:
        product_id = cart_item[3]
        quantity = cart_item[2]
        sql = "SELECT * FROM Product WHERE product_id = %s"
        values = (product_id,)
        cursor.execute(sql, values)
        product = cursor.fetchone()
        price = float(product[3])
        discount = float(product[6])
        mrp = float(product[4])
        selling_price = (mrp - (mrp * discount / 100))
        total_amount += selling_price * quantity

    print("Total amount:", total_amount)
    confirmation = input("Do you want to place the order? (Y/N): ")
    if confirmation.lower() == 'y':
        sql = "INSERT INTO order_placed (total_amount, order_status, customer_id, product_id) VALUES (%s, %s, %s, %s)"
        values = (total_amount, 'Pending', user_id, product_id)
        cursor.execute(sql, values)
        order_id = cursor.lastrowid

        # Update the product quantity in the Product table
        for cart_item in cart_items:
            product_id = cart_item[3]
            quantity = cart_item[2]
            sql = "UPDATE Product SET quantity = quantity - %s WHERE product_id = %s"
            cursor.execute(sql, (quantity, product_id))

        # Clear the user's cart
        sql = "DELETE FROM Cart WHERE customer_id = %s"
        cursor.execute(sql, (user_id,))

        db.commit()
        print("Order has been placed successfully.")
    else:
        print("Order has been cancelled.")



def conflicting_transactions():
    try:
        with db.cursor() as cur:

            cur.execute("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE")

            #Transaction 1
            cur.execute("SELECT quantity FROM product WHERE product_name = 'Product A' FOR UPDATE")
            quantity = cur.fetchone()[0]
            cur.execute("UPDATE product SET quantity = 50 WHERE product_name = 'Product A'")
            print("Transaction 1: Updated product A quantity to 50")

            #Transaction 2
            cur.execute("SELECT quantity FROM product WHERE product_name = 'Product A' FOR UPDATE")
            mrp = cur.fetchone()[0]
            cur.execute("UPDATE product SET quantity = 60 WHERE product_name = 'Product A'")
            print("Transaction 2: Updated product A quantity to 60")

            db.commit()
            print("Both transactions committed successfully")
    except Exception as e:
        db.rollback()
        print("Error occurred, rolling back transaction")
        print(e)


def non_conflicting_transactions():
    try:
        cur = db.cursor()

        #Transaction 1
        cur.execute("INSERT INTO customer (first_name, middle_name, last_name, email, password, address, phone_number) VALUES ('Shah', 'Rukh', 'Khan', 'shahrukhkhan@gmail.com', 'password123', 'Mannat Mumbai', '9087321652')")
        print("Transaction 1: Inserted a new customer.")

        #Transaction 2
        cur.execute("UPDATE customer SET last_name = 'sharma' WHERE first_name = 'khwaish'")
        print("Transaction 2: Updated the last name of customer.")

        #Transaction 3
        cur.execute("DELETE FROM customer WHERE first_name = 'aamir'")
        print("Transaction 3: Deleted a customer.")

        #Transaction 4
        cur.execute("SELECT COUNT(*) FROM customer")
        count = cur.fetchone()[0]
        print(f"Transaction 4: There are {count} customers in the database.")
        
        db.commit()
        print("All transactions committed successfully.")
        
    except (Exception, mysql.DatabaseError) as error:
        print("Error occurred during transaction, rolling back.")
        db.rollback()
        print(error)



def logout():
    print("Logout successful.")


def add_product():
    product_name = input("Enter product name: ")
    category_id = input("Enter category id: ")
    MRP = input("Enter MRP: ")
    quantity = input("Enter quantity: ")
    brand = input("Enter brand (or leave blank for generic): ")
    discount = input("Enter discount (in percentage, leave blank for 0): ")
    mfg_date = input("Enter manufacturing date (dd): ")
    mfg_month = input("Enter manufacturing month (mm): ")
    mfg_year = input("Enter manufacturing year (yyyy): ")
    expiry_date = input("Enter expiry date (dd): ")
    expiry_weeks = input("Enter expiry in weeks: ")
    expiry_months = input("Enter expiry in months: ")
    cursor = db.cursor()
    query = "INSERT INTO Product (product_name, category_id, MRP, quantity, brand, discount, mfg_date, mfg_month, mfg_year, expiry_date, expiry_weeks, expiry_months) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    values = (product_name, category_id, MRP, quantity, brand, discount, mfg_date, mfg_month, mfg_year, expiry_date, expiry_weeks, expiry_months)
    cursor.execute(query, values)
    db.commit()
    print("Product added successfully")

def remove_product():
    product_id = input("Enter product id to remove: ")
    cursor = db.cursor()
    query = "DELETE FROM Product WHERE product_id = %s"
    values = (product_id,)
    cursor.execute(query, values)
    db.commit()
    print("Product removed successfully")

def view_all_orders():
    cursor = db.cursor()
    cursor.execute("SELECT * FROM order_placed")
    rows = cursor.fetchall()
    for row in rows:
        print(row)

def update_order_status():
    cursor = db.cursor()
    order_id = input("Enter the order ID: ")
    status = input("Enter the new status (Pending/Shipped/Delivered): ")
    cursor.execute("UPDATE order_placed SET order_status=%s WHERE order_id=%s", (status, order_id))
    db.commit()
    print("Order status updated successfully!")


def admin_menu(admin_id):
    print("Welcome Admin!")
    while True:
        print("""
        1. Add product
        2. Remove product
        3. View all orders
        4. Update order status
        5. Logout
        """)
        choice = input("Enter your choice: ")
        if choice == "1":

            add_product()
        elif choice == "2":
            remove_product()
        elif choice == "3":
            view_all_orders()
        elif choice == "4":
            update_order_status()
        elif choice == "5":
            logout()
            break
        else:
            print("Invalid choice! Try again.")


def main():
    while True:
        print("\nWelcome to Online Retail Store")
        print("""
        1. Customer Signup
        2. Customer Login
        3. Admin Login
        4. View Products
        5. Execute 2 conflicting transactions
        6. Execute 4 non-conflicting transactions
        7. Execute OLAP queries
        8. Execute Triggers
        9. Exit""")

        choice = input("\nEnter your choice: ")

        if choice == '1':
            signup()
        elif choice == '2':
            user_id = login()
            if user_id is not None:
                user_menu(user_id)
        elif choice == '3':
            admin_id = admin_login()
            if admin_id is not None:
                admin_menu(admin_id)
        elif choice == '4':
            view_products()
        elif choice == "5":
            conflicting_transactions()
        elif choice == "6":
            non_conflicting_transactions()
        elif choice == "7":
            print("\n1. Category vs brand vs total_sales");
            execute_query(query3)
            print("\n2. Total sales of each year ")
            execute_query(query4)
            print("\n3. Order count wrt order_status")
            execute_query(query5)
            print("\n4. total number of customers wrt the year in which they have created the account")
            execute_query(query6)
        elif choice == "8":
            print("1 substract quantity from product when order is placed")
            execute_query(q7)
            execute_query(q8)
            print("2. dont allow to enter duplicate phone numbers")
            execute_query(q9)
            execute_query(q10)
        # elif choice == '4':
        #     view_cart()
        # elif choice == '5':
        #     add_to_cart()
        # elif choice == '6':
        #     remove_from_cart()
        # elif choice == '7':
        #     place_order()
        # elif choice == '8':
        #     logout()
        elif choice == '9':
            print("\nThank you for using Online Retail Store!")
            break
        else:
            print("\nInvalid choice. Please try again.")

main()
db.close()