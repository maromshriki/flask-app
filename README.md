# flask-app
Flask Production-like Deployment – Summary
📌 מה השגתי בפרויקט
בניית אפליקציית Flask עם חיבור ל־PostgreSQL
האפליקציה מסוגלת להתחבר למסד הנתונים באמצעות psycopg2 תוך שימוש במשתני סביבה.
הטמעה של retry mechanism למקרה שה־DB לא מוכן מיידית.
Dockerization של האפליקציה
יצירת Dockerfile מותאם להרצת Flask עם כל הדרישות (psycopg2-binary וכו’).
הרצת קונטיינר עם env file שמכיל את כל הסודות באופן מוגן.
CI/CD עם GitHub Actions
אוטומציה מלאה: build → test → push ל־ECR → deploy על EC2.
שימוש ב־Secrets של GitHub כדי לנהל סיסמאות ומפתחות בצורה בטוחה.
שליחת פקודות להרצה ב־EC2 דרך AWS SSM, ללא צורך ב־SSH.
הרצת EC2 מבוסס ALB/ASG
EC2 מוגדר עם IAM Role שמאפשר שימוש ב־SSM והתחברות ל־ECR.
Load Balancer מול קונטיינרים עם Health Check.
Auto Scaling Group להבטחת זמינות והגדלת Instances לפי צורך.
ניהול סודות ובטיחות
Env file מוגן (chmod 600) ומוצמד לקונטיינר בצורה מאובטחת.
הימנעות מחשיפת סיסמאות בקוד או בקונטיינר עצמו.
Debugging ו־Production Hardening
ניהול retries וחיבור למאגר נתונים שנמצא ברשת פרטית (RDS).
טיפול ב־permission issues לקובץ env בקונטיינר.
בדיקת חיבור ל־DB מתוך הקונטיינר והאפליקציה.
📂 מבנה הפרויקט
/project-root
├─ app/                   # קוד המקור של Flask
│  ├─ main.py             # Flask app
│  └─ requirements.txt
├─ .github/workflows/
│  └─ ci-cd.yaml          # GitHub Actions CI/CD
├─ terraform/             # קבצי Terraform (VPC, EC2, RDS, ECR, LB, ASG)
│  ├─ variables.tf
│  ├─ iam.tf
│  ├─ rds.tf
│  ├─ ecr.tf
│  ├─ security_groups.tf
│  ├─ ec2.tf
│  └─ lb.tf
├─ Dockerfile
└─ README.md
⚡ איך להשתמש בפרויקט
הגדר Secrets ב־GitHub
DB_HOST, DB_PORT, DB_USER, DB_PASS, DB_NAME
AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
הרצת GitHub Actions
בכל push ל־main האפליקציה תבנה, תבדק, תדחף ל־ECR ותפורס על ה־EC2 (SSM).
גישה לאפליקציה
ה־ALB מספק URL ציבורי.
Health check מוודא שהקונטיינרים פועלים.
Docker & Env File
הקונטיינר רץ עם --env-file שמכיל את כל משתני הסביבה.
הקובץ מאובטח עם chmod 600 ואינו גלוי למשתמשים אחרים.
סקיילינג והוספת EC2 נוספים
ASG מנהל Instances נוספים.
ניתן להוסיף Tag Role=flask-server ל־EC2 חדשים כדי שה־SSM יקבל אותם אוטומטית.
פיתוח מקומי

ניתן להריץ את הקונטיינר מקומית:

docker run -d -p 5000:5000 --env-file flask.env flask-app:latest
לוודא ש־env file מכיל את כל משתני ה־DB הדרושים.
🎯 מה למדתי / התמקצעות
שילוב Flask + PostgreSQL + Docker + AWS (EC2, RDS, ECR, ALB, ASG).
ניהול סודות בצורה מאובטחת עם GitHub Actions ו־Env files.
שימוש ב־SSM ל־remote command execution ללא SSH.
הבנה עמוקה של permission issues בקונטיינרים והקשרים בין Host ל־Container.
יישום retry mechanisms ו־logging לחיבור DB.
בנייה של CI/CD end-to-end: push → build → test → deploy.
