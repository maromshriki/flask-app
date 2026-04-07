# שימוש ב־Python lightweight image
FROM python:3.11-slim

# הגדרת תיקיית עבודה
WORKDIR /app

# העתקת קבצים
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# חשיפת פורט
EXPOSE 5000

# הרצת האפליקציה
CMD ["python", "app.py"]
