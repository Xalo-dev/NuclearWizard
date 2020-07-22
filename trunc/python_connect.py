# -*- coding: utf-8 -*-
"""
Initialize database connection to nuclear_wizard
"""

import mysql.connector

mydb = mysql.connector.connect(
        host="localhost",
        user="theorist",
        password="theorist",
        database="nuclear_wizard"
    )

mycursor = mydb.cursor()

nucleusInsert ="INSERT INTO nucleus VALUES (%s, %s, %s, %s, %s, %s, %s)"
nuclei = [('205Tl',205,81,None,None,None,'1/2+'),
          ('205Pb',205,82,1.73,7,'Y','5/2-')]

mycursor.executemany(nucleusInsert, nuclei)

mydb.commit()