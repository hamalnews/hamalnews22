# استخدام بيئة بايثون رسمية
FROM python:3.9-slim

# ضبط العمل في المجلد الرئيسي
WORKDIR /app

# تثبيت أدوات النظام الضرورية للتحميل المخفي
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# تثبيت المكتبات من ملف requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# نسخ كل المجلدات (src, ui, core) إلى السيرفر
COPY . .

# فتح منفذ الويب العالمي
EXPOSE 7860

# أمر تشغيل البوابة الرئيسية
CMD ["streamlit", "run", "app.py", "--server.port=7860", "--server.address=0.0.0.0"]
