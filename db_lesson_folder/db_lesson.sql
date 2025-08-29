-- Q1: departments テーブル作成
CREATE TABLE departments (
department_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
name VARCHAR(20) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(department_id)
);

-- Q2: people テーブルに department_id カラム追加
ALTER TABLE people
ADD COLUMN department_id INT UNSIGNED AFTER email;

-- Q3: レコード挿入
-- 部署
INSERT INTO departments (name) VALUES
('営業'), ('開発'), ('経理'), ('人事'), ('情報システム');

-- 人
INSERT INTO people (name, email, department_id, age, gender) VALUES
('佐藤一郎', 'ichiro@example.com', 1, 25, 1),
('佐藤二郎', 'jiro@example.com', 1, 26, 1),
('佐藤三子', 'miko@example.com', 1, 27, 2),
('佐藤四郎', 'shiro@example.com', 2, 28, 1),
('佐藤五月', 'satsuki@example.com', 2, 29, 2),
('佐藤六郎', 'rokuro@example.com', 2, 30, 1),
('佐藤七海', 'nanami@example.com', 2, 31, 2),
('佐藤八月', 'hazuki@example.com', 3, 32, 2),
('佐藤九九', 'kuku@example.com', 4, 33, 1),
('佐藤十子', 'toko@example.com', 5, 34, 2);

-- 日報
INSERT INTO reports (person_id, content) VALUES
(1,'本日は新規顧客の対応を行いました。'),
(2,'開発チームと仕様の最終確認を実施しました。'),
(3,'資料作成とプレゼン準備を進めました。'), 
(4,'コードレビューを終えて、修正点を共有しました。'),
(5,'システムの監視設定を行いました。'),
(6,'新機能のテストを実施し、不具合を報告しました。'),
(7,'ユーザーフィードバックの分析を開始しました。'),
(8,'経理部と予算の調整をしました。'),
(9,'人事面談を行い、課題を話し合いました。'),
(10,'ミーティングで進捗報告を行いました。');

-- Q4: department_id の NULL を更新
UPDATE people
SET department_id = 1
 WHERE department_id IS NULL AND age < 25;

UPDATE people
SET department_id = 2
WHERE department_id IS NULL ANd age >= 25 AND age < 35;

UPDATE people
SET department_id = 3
WHERE department_id IS NULL AND age >= 35;

-- Q5: 男性の名前と年齢を年齢降順で取得
SELECT name, age
FROM people
WHERE gender = 1
ORDER BY age DESC;

-- Q6: SQL文の日本語説明
-- SELECT name, email, age
-- FROM people
-- WHERE department_id = 1
-- ORDER BY created_at;
--peopleテーブル から、department_idカラムが1のレコードを抽出し、その中からname,email,age の カラムを表示し、created_atカラムで並べ替える処理です。

-- Q7: 20代女性と40代男性の名前一覧
SELECT name
FROM people
WHERE (gender = 2 AND age BETWEEN 20 AND 29)
OR (gender = 1 AND age BETWEEN 40 AND 49);

-- Q8: 営業部の人を年齢昇順で取得
SELECT * 
FROM people
WHERE department_id = 1
ORDER BY age ASC;

-- Q9: 開発部の女性平均年齢
SELECT AVG(age) AS average_age
FROM people
WHERE department_id = 2 AND gender = 2;

-- Q10: 名前・部署名・日報内容を同時取得
SELECT p.name, d.name AS department_name, r.content
FROM people p
JOIN departments d ON p.department_id = d.department_id
JOIN reports r ON p.person_id = r.person_id;

-- Q11: 日報未提出者の名前一覧
SELECT name
FROM people
WHERE person_id NOT IN (SELECT person_id FROM reports);


