-- MySQL dump 10.13  Distrib 8.4.9, for Linux (x86_64)
--
-- Host: localhost    Database: chatdb
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `chatdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `chatdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `chatdb`;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversations`
--

LOCK TABLES `conversations` WRITE;
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` VALUES (1,'2026-11-17 16:49:34'),(2,'2026-11-18 13:41:51'),(3,'2026-11-18 13:41:51'),(4,'2026-11-18 13:46:09'),(5,'2026-11-18 13:47:11'),(6,'2026-11-18 13:49:46');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `conversation_id` int NOT NULL,
  `role` enum('user','assistant') NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_messages_conversation` (`conversation_id`,`id`),
  CONSTRAINT `fk_messages_conversation` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,'user','Hello! What is FastAPI?','2026-11-17 16:49:34'),(2,1,'assistant','FastAPI is a modern Python web framework for building APIs quickly, with automatic validation and interactive documentation.','2026-11-17 16:49:34'),(3,1,'user','Is it fast?','2026-11-17 16:49:34'),(4,1,'assistant','Yes. It is built on Starlette and Pydantic and performs on par with Node.js and Go frameworks in many benchmarks.','2026-11-17 16:49:34'),(5,2,'user','שלום','2026-11-18 13:41:51'),(6,2,'assistant','שלום! איך אני יכול לעזור לך היום?','2026-11-18 13:41:54'),(7,3,'user','say hi','2026-11-18 13:42:00'),(8,3,'assistant','Hi! ¿Cómo puedo ayudarte hoy?','2026-11-18 13:42:02'),(9,2,'user','מה צבע השמיים','2026-11-18 13:42:04'),(10,2,'assistant','השמיים בדרך כלל כחולים ביום בהיר, בשל פיזור ריילי של אור השמש על ידי האטמוספירה. עם זאת, הם יכולים להשתנות בהתאם לשעה ביום, מזג האוויר ומצבים אחרים, כמו בזמן הזריחה או השקיעה אז הם יכולים להיות גוונים של ורוד, כתום ואדום. בלילה, השמיים נראים חשוכים בגלל היעדר אור שמש ישיר, אך מלאים בכוכבים אם התנאים מאפשרים זאת.','2026-11-18 13:42:07'),(11,4,'user','Hello! Tell me a fun fact.','2026-11-18 13:46:09'),(12,4,'assistant','Hello! Did you know that honey never spoils? Archaeologists have found pots of honey in ancient Egyptian tombs that are over 3,000 years old and still perfectly edible!','2026-11-18 13:46:11'),(13,4,'user','Can you explain that in one sentence?','2026-11-18 13:46:11'),(14,4,'assistant','Certainly! Honey\'s natural composition and low moisture content prevent it from spoiling, allowing it to remain edible for thousands of years.','2026-11-18 13:46:12'),(15,5,'user','שלום','2026-11-18 13:47:11'),(16,5,'assistant','שלום! איך אפשר לעזור לך היום?','2026-11-18 13:47:12'),(17,5,'user','איך קוראים לך?','2026-11-18 13:47:23'),(18,5,'assistant','אני עוזר וירטואלי שנקרא Assistant, ואין לי שם אישי כמו שיש לבני אדם. איך אפשר לעזור לך היום?','2026-11-18 13:47:24'),(19,5,'user','מי יצראותך','2026-11-18 13:47:39'),(20,5,'assistant','פיתחה אותי OpenAI, חברה שמתמחה בתחום הבינה המלאכותית. יש משהו ספציפי שאתה מעוניין לדעת עליו יותר?','2026-11-18 13:47:40'),(21,5,'user','כמה עולה קוטג בסופר?','2026-11-18 13:48:04'),(22,5,'assistant','מחיר של קוטג\' בסופר יכול להשתנות בהתאם למותג, למקום הקנייה, למבצעים ועוד. בדרך כלל, המחיר נע בין 5 ל-10 שקלים ליחידה של 250 גרם. אני ממליץ לבדוק את המחירים בסופרמרקט המקומי שלך או באתרים שלהם כדי לקבל מידע מעודכן.','2026-11-18 13:48:05'),(23,5,'user','תן לי מתכון לשקשוקה','2026-11-18 13:48:22'),(24,5,'assistant','בשמחה! הנה מתכון בסיסי לשקשוקה:\n\n**מצרכים:**\n- 2 כפות שמן זית\n- 1 בצל גדול, קצוץ\n- 1 פלפל אדום, חתוך לקוביות\n- 2 שיני שום, קצוצות\n- 4 עגבניות בשלות, חתוכות לקוביות (או קופסת שימורים של עגבניות מרוסקות)\n- 2 כפות רסק עגבניות\n- 1 כפית כמון\n- 1 כפית פפריקה\n- מעט פלפל קאיין או פתיתי צ\'ילי (לא חובה, לפי הטעם)\n- מלח ופלפל לפי הטעם\n- 4–6 ביצים\n- פטרוזיליה טרייה לקישוט\n\n**אופן ההכנה:**\n\n1. חמם שמן זית במחבת גדולה על אש בינונית.\n2. הוסף את הבצל וטגן עד שהוא שקוף.\n3. הוסף את הפלפל האדום והמשך לטגן עוד כ-5 דקות עד שהוא מתרכך.\n4. הוסף את השום וטגן כדקה נוספת.\n5. הוסף את העגבניות, רסק העגבניות, כמון, פפריקה, פלפל קאיין (אם משתמשים), מלח ופלפל. ערבב היטב.\n6. הורד את האש לנמוכה ובשל את התערובת למשך כ-10 דקות עד שהרוטב מסמיך מעט.\n7. צור גומות ברוטב ושבור לתוכן את הביצים בעדינות.\n8. כסה את המחבת ובשל על אש נמוכה כ-5–8 דקות, או עד שהביצים מתבשלות לפי ההעדפה שלך.\n9. קשט את השקשוקה בפטרוזיליה טרייה והגיש עם לחם טרי או חלה.\n\nבתיאבון! 🌿','2026-11-18 13:48:26'),(25,5,'user','אתה יכול לבנות אפליקציות לאייפון שמשתמשת בספירת צעדים','2026-11-18 13:49:03'),(26,5,'assistant','אני לא יכול לבנות אפליקציות בעצמי, אבל אני יכול לתת לך עקרונות והכוונה כללית על איך אפשר לפתח אפליקציה כזו.\n\nכדי ליצור אפליקציה לאייפון שמשתמשת בספירת צעדים, תוכל להשתמש ב-HealthKit, כלי שמתאפשר על ידי Apple כדי לגשת לנתוני בריאות וכושר.\n\nלהלן שלבים כללים לפיתוח אפליקציה כזו:\n\n1. **התקן את סביבת הפיתוח Xcode**: זה הכלי העיקרי לפיתוח יישומי iOS.\n\n2. **צור פרויקט חדש**: ב-Xcode, התחל פרויקט חדש ובחר Single View App כבסיס.\n\n3. **אפשרות ל-HealthKit**: ודא שהפרויקט שלך מופעל לשימוש ב-HealthKit. זה כולל הגדרות בפרויקט שלך ובקשת הרשאה מהמשתמש.\n\n4. **הוסף את הספריות הדרושות**: הוסף את HealthKit לפרויקט שלך. יש לייבא את המודול באמצעות `import HealthKit`.\n\n5. **בקש הרשאות ממשתמשים**: בעת הפעלת האפליקציה, בקש הרשאות לגשת לנתוני בריאות, כולל צעדים.\n\n6. **גישה לנתוני צעדים**:\n   - צרו מופע של `HKHealthStore`.\n   - בדקו אם המכשיר יכול לשתף ולאחסן נתוני צעדים.\n   - בקשו את הנתונים על ידי יצירת שאילתה שבודקת את המספר הכולל של הצעדים על פני תקופת זמן מסוימת.\n\n7. **הצגת נתונים באפליקציה**: השתמש ב-UI כדי להציג את מספר הצעדים למשתמש, באמצעות תוויות, גרפים או כל פורמט שמתאים לעיצוב שלך.\n\n8. **בדיקה ושיפורים**: בדוק היטב את האפליקציה על מכשירים שונים ומערכות iOS שונות כדי להבטיח שהיא פועלת בצורה תקינה.\n\n9. **פרסם את האפליקציה ב-App Store**: לאחר פיתוח ובדיקה, תוכל להגיש את האפליקציה לסקירה ב-App Store.\n\nאם אתה לא מנוסה בפיתוח iOS, ייתכן שתרצה ללמוד עוד על Swift ו-HealthKit דרך משאבים מקוונים או קורסים מקוונים.','2026-11-18 13:49:09'),(27,6,'user','מי עדיף צאט גיפיטי או קלוד','2026-11-18 13:49:46'),(28,6,'assistant','ההעדפה בין ChatGPT ל-Claude תלויה בצרכים הספציפיים שלך. \n\n- **ChatGPT** (כמו אני, למשל) פותח על ידי OpenAI ומתמקד בעיקר בשיחות כלליות, מענה לשאלות ומתן תמיכה בתחומים מגוונים.\n\n- **Claude** פותח על ידי חברת Anthropic ומתמקד גם הוא בשיחות וניהול אינטראקציות עם המשתמשים, תוך דגש על לשמור על אתיקה וערכים.\n\nשניהם כלים טובים, אך אם יש לך שימושים מאוד ספציפיים, כדאי לבדוק מי מהם עונה בצורה הטובה ביותר על הצרכים שלך.','2026-11-18 13:49:48'),(29,6,'user','אם היית צריך למחוק את כל הai הקיימים ולהשאיר אחד מי היית משאיר?','2026-11-18 13:50:20'),(30,6,'assistant','בחירה בכלי AI אחד להשאיר היא משימה מאתגרת, והיא תלויה בגורמים רבים כמו מגוון השימושים, הדיוק והבטיחות. אם היינו צריכים לבחור, היבטים כמו המועילות הרחבה, היכולת להתמודד עם משימות מגוונות, וביסוס אתי וטכנולוגי היו נכנסים לשיקול. חשוב להבין שאין תשובה אחת נכונה, וכל אחד עשוי לבחור אחרת בהתאם לצרכים והדרישות שלו.','2026-11-18 13:50:22'),(31,6,'user','תבחר אחד','2026-11-18 13:50:41'),(32,6,'assistant','אם הייתי צריך לבחור אחד, הייתי נוטה לבחור ב-ChatGPT. הסיבה לכך היא הגמישות הרבה שלו במגוון תחומים, היכולת שלו לנהל שיחות מורכבות עם משתמשים, ותמיכה רחבה שהוא מציע בתפקידים שונים. חשוב לזכור שהבחירה הזו משקפת את היתרונות שאני מכיר, וייתכן שאנשים אחרים יתעדפו כלים שונים בהתאם לצרכים האישיים שלהם.','2026-11-18 13:50:43'),(33,6,'user','אתה יכול לבנות לי תמונה של כלב','2026-11-18 13:51:20'),(34,6,'assistant','אין לי את היכולת ליצור או לבנות תמונות ישירות. עם זאת, ישנם כלים רבים, כמו Midjourney או DALL-E, שיכולים לייצר תמונות באמצעות טכנולוגיית בינה מלאכותית. אתה יכול לנסות להשתמש באחד מהכלים הללו כדי ליצור תמונה של כלב.','2026-11-18 13:51:21');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'chatdb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-18 13:53:30
