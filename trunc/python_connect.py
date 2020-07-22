# -*- coding: utf-8 -*-
"""
Initialize database connection nuclear_wizard
"""

import mysql.connector

mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="root"
    )

print(mydb)
