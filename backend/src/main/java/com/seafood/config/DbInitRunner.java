package com.seafood.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import java.util.List;
import java.util.Map;

@Component
public class DbInitRunner implements CommandLineRunner {

    private static final Logger logger = LoggerFactory.getLogger(DbInitRunner.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) throws Exception {
        logger.info("Initializing Database Tables...");

        // 1. Create pms_product if not exists
        String createProductTable = "CREATE TABLE IF NOT EXISTS pms_product (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "category_id BIGINT," +
                "name VARCHAR(200) NOT NULL," +
                "price DECIMAL(10,2)," +
                "original_price DECIMAL(10,2)," +
                "stock INT," +
                "origin VARCHAR(50)," +
                "catch_date DATE," +
                "farming_method VARCHAR(50)," +
                "description TEXT," +
                "main_image VARCHAR(500)," +
                "detail_images TEXT," +
                "status INT DEFAULT 1," +
                "create_time DATETIME DEFAULT CURRENT_TIMESTAMP" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createProductTable);

        // 2. Create trace_record if not exists
        String createTraceTable = "CREATE TABLE IF NOT EXISTS trace_record (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "product_id BIGINT NOT NULL," +
                "node_name VARCHAR(50)," +
                "node_time DATETIME," +
                "location VARCHAR(100)," +
                "operator VARCHAR(50)," +
                "description TEXT," +
                "image VARCHAR(255)" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createTraceTable);

        // 3. Create oms_order if not exists
        String createOrderTable = "CREATE TABLE IF NOT EXISTS oms_order (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "order_sn VARCHAR(64) UNIQUE," +
                "user_id BIGINT," +
                "receiver_name VARCHAR(50)," +
                "receiver_phone VARCHAR(20)," +
                "receiver_address VARCHAR(255)," +
                "total_amount DECIMAL(10,2)," +
                "status INT DEFAULT 0," + // 0:Pending, 1:Paid/ToShip, 2:Shipped, 3:Completed
                "create_time DATETIME DEFAULT CURRENT_TIMESTAMP," +
                "payment_time DATETIME," +
                "delivery_time DATETIME," +
                "receive_time DATETIME" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createOrderTable);
        
        // Add missing columns if needed (idempotent check)
        try { jdbcTemplate.execute("ALTER TABLE oms_order ADD COLUMN receiver_name VARCHAR(50)"); } catch (Exception ignored) {}
        try { jdbcTemplate.execute("ALTER TABLE oms_order ADD COLUMN receiver_phone VARCHAR(20)"); } catch (Exception ignored) {}
        try { jdbcTemplate.execute("ALTER TABLE oms_order ADD COLUMN receiver_address VARCHAR(255)"); } catch (Exception ignored) {}

        // 4. Create oms_order_item if not exists
        String createOrderItemTable = "CREATE TABLE IF NOT EXISTS oms_order_item (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "order_id BIGINT NOT NULL," +
                "product_id BIGINT," +
                "product_name VARCHAR(200)," +
                "product_price DECIMAL(10,2)," +
                "quantity INT," +
                "product_image VARCHAR(500)" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createOrderItemTable);

        // 5. Create sys_user if not exists
        String createUserTable = "CREATE TABLE IF NOT EXISTS sys_user (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "username VARCHAR(50) UNIQUE NOT NULL," +
                "password VARCHAR(100) NOT NULL," +
                "nickname VARCHAR(50)," +
                "role VARCHAR(20) DEFAULT 'CUSTOMER'," +
                "avatar VARCHAR(255)," +
                "create_time DATETIME DEFAULT CURRENT_TIMESTAMP" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createUserTable);

        // 6. Create sys_address if not exists
        String createAddressTable = "CREATE TABLE IF NOT EXISTS sys_address (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "user_id BIGINT NOT NULL," +
                "name VARCHAR(50) NOT NULL," +
                "phone VARCHAR(20) NOT NULL," +
                "detail VARCHAR(255) NOT NULL," +
                "is_default INT DEFAULT 0," +
                "create_time DATETIME DEFAULT CURRENT_TIMESTAMP," +
                "update_time DATETIME DEFAULT CURRENT_TIMESTAMP" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createAddressTable);

        // 7. Create pms_category if not exists
        String createCategoryTable = "CREATE TABLE IF NOT EXISTS pms_category (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "name VARCHAR(50) NOT NULL," +
                "icon VARCHAR(255)," +
                "sort INT DEFAULT 0," +
                "status INT DEFAULT 1," + // Added status column
                "create_time DATETIME DEFAULT CURRENT_TIMESTAMP" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createCategoryTable);
        
        // Add missing columns if needed (idempotent check)
        try { jdbcTemplate.execute("ALTER TABLE pms_category ADD COLUMN status INT DEFAULT 1"); } catch (Exception ignored) {}

        // 8. Insert default categories if empty
        Integer catCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM pms_category", Integer.class);
        if (catCount == 0) {
            String insertCatSql = "INSERT INTO pms_category (name, icon, sort, status) VALUES (?, ?, ?, ?)";
            jdbcTemplate.update(insertCatSql, "鱼类", "https://img.yzcdn.cn/vant/logo.png", 1, 1);
            jdbcTemplate.update(insertCatSql, "虾类", "https://img.yzcdn.cn/vant/logo.png", 2, 1);
            jdbcTemplate.update(insertCatSql, "蟹类", "https://img.yzcdn.cn/vant/logo.png", 3, 1);
            jdbcTemplate.update(insertCatSql, "贝类", "https://img.yzcdn.cn/vant/logo.png", 4, 1);
            logger.info("Inserted default categories.");
        } else {
            // Force update category names and icons to ensure no encoding issues and distinct icons
            String updateCatSql = "UPDATE pms_category SET name = ?, icon = ? WHERE sort = ?";
            jdbcTemplate.update(updateCatSql, "鱼类", "/uploads/yulei.jpg", 1);
            jdbcTemplate.update(updateCatSql, "虾类", "/uploads/xialei.jpg", 2);
            jdbcTemplate.update(updateCatSql, "蟹类", "/uploads/xielei.jpg", 3);
            jdbcTemplate.update(updateCatSql, "贝类", "/uploads/belei.jpg", 4);
            logger.info("Updated category names and icons.");
        }

        // 6. Insert default admin user
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM sys_user WHERE username = 'admin'", Integer.class);
        if (count == 0) {
            jdbcTemplate.execute("INSERT INTO sys_user (username, password, nickname, role) VALUES ('admin', '123456', 'Administrator', 'ADMIN')");
            logger.info("Created default admin user.");
        }
        
        // 7. Insert test user
        Integer userCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM sys_user WHERE username = 'test'", Integer.class);
        if (userCount == 0) {
            jdbcTemplate.execute("INSERT INTO sys_user (username, password, nickname, role) VALUES ('test', '123456', 'TestUser', 'CUSTOMER')");
            logger.info("Created test user.");
        }

        // 9. Create pms_recipe if not exists
        String createRecipeTable = "CREATE TABLE IF NOT EXISTS pms_recipe (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "product_id BIGINT," +
                "title VARCHAR(200) NOT NULL," +
                "content TEXT," +
                "image VARCHAR(500)," +
                "create_time DATETIME DEFAULT CURRENT_TIMESTAMP" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createRecipeTable);

        // 10. Create pms_region_stock if not exists
        String createRegionStockTable = "CREATE TABLE IF NOT EXISTS pms_region_stock (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "region_name VARCHAR(50) NOT NULL," +
                "stock_count INT DEFAULT 0" +
                ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";
        jdbcTemplate.execute(createRegionStockTable);

        // 11. Generate Mock Data (Products + Trace + Orders + Recipes + RegionStock)
        generateMockData();

        logger.info("Database initialization completed.");
    }

    private void generateMockData() {
        Random random = new Random();
        
        // Generate Region Stock Data
        Integer regionCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM pms_region_stock", Integer.class);
        if (regionCount != null && regionCount == 0) {
            String[] regions = {"浙江省", "辽宁省", "山东省", "广东省", "福建省", "江苏省", "河北省", "广西壮族自治区"};
            String insertRegionSql = "INSERT INTO pms_region_stock (region_name, stock_count) VALUES (?, ?)";
            for (String region : regions) {
                jdbcTemplate.update(insertRegionSql, region, random.nextInt(5000) + 1000);
            }
            logger.info("Generated region stock data.");
        }

        // 8.1 Products
        Integer productCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM pms_product", Integer.class);
        if (productCount != null && productCount == 0) {
            logger.info("Generating mock products and trace records...");
            
            String[] categories = {"鱼类", "虾类", "蟹类", "贝类"};
            // Use Provinces/Cities suitable for map
            String[] origins = {"舟山", "大连", "青岛", "湛江", "宁波", "威海", "厦门", "连云港"};
            String[] methods = {"野生捕捞", "深海养殖", "近海养殖"};
            
            String[] fishNames = {"大黄鱼", "带鱼", "鲳鱼", "海鲈鱼", "石斑鱼", "多宝鱼", "马鲛鱼", "金枪鱼"};
            String[] shrimpNames = {"基围虾", "对虾", "皮皮虾", "北极甜虾", "波士顿龙虾", "澳洲龙虾"};
            String[] crabNames = {"梭子蟹", "帝王蟹", "面包蟹", "青蟹", "大闸蟹"};
            String[] shellNames = {"扇贝", "生蚝", "鲍鱼", "蛤蜊", "蛏子"};
            
            String insertProdSql = "INSERT INTO pms_product (category_id, name, price, original_price, stock, origin, catch_date, farming_method, description, main_image, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            String insertTraceSql = "INSERT INTO trace_record (product_id, node_name, node_time, location, operator, description, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
            String insertRecipeSql = "INSERT INTO pms_recipe (product_id, title, content, image) VALUES (?, ?, ?, ?)";
            
            for (int i = 1; i <= 50; i++) {
                int catIdx = random.nextInt(4);
                String baseName = "";
                String categoryIcon = "";
                if (catIdx == 0) { baseName = fishNames[random.nextInt(fishNames.length)]; categoryIcon = "/uploads/yulei.jpg"; }
                else if (catIdx == 1) { baseName = shrimpNames[random.nextInt(shrimpNames.length)]; categoryIcon = "/uploads/xialei.jpg"; }
                else if (catIdx == 2) { baseName = crabNames[random.nextInt(crabNames.length)]; categoryIcon = "/uploads/xielei.jpg"; }
                else { baseName = shellNames[random.nextInt(shellNames.length)]; categoryIcon = "/uploads/belei.jpg"; }
                
                String name = (i % 3 == 0) ? baseName + " (特级)" : baseName;
                BigDecimal price = new BigDecimal(random.nextInt(500) + 50);
                BigDecimal originalPrice = price.add(new BigDecimal(random.nextInt(50) + 10));
                int stock = random.nextInt(150) + 10;
                String origin = origins[random.nextInt(origins.length)];
                LocalDate catchDate = LocalDate.now().minusDays(random.nextInt(30));
                String method = methods[random.nextInt(methods.length)];
                String desc = "产自" + origin + "的优质" + name + "，" + method + "，新鲜直达。";
                String image = "https://img.yzcdn.cn/vant/apple-" + (random.nextInt(2) + 1) + ".jpg";
                
                jdbcTemplate.update(insertProdSql, catIdx + 1, name, price, originalPrice, stock, origin, catchDate, method, desc, image, 1);
                
                // Get inserted ID (simplified, assuming auto-increment starts/continues)
                Long productId = jdbcTemplate.queryForObject("SELECT MAX(id) FROM pms_product", Long.class);

                // Insert Recipe (One per product for demo)
                String recipeTitle = name + "清蒸做法";
                String recipeContent = "1. 将" + name + "洗净；\n2. 放入蒸锅蒸10分钟；\n3. 淋上热油和酱油即可。";
                jdbcTemplate.update(insertRecipeSql, productId, recipeTitle, recipeContent, categoryIcon);
                
                // Generate Trace Records
                // Node 1: Capture
                jdbcTemplate.update(insertTraceSql, productId, "捕捞/采摘", catchDate.atTime(8, 0), origin, "渔船-" + random.nextInt(99), "完成捕捞作业", image);
                // Node 2: Processing (1 day later)
                jdbcTemplate.update(insertTraceSql, productId, "加工分拣", catchDate.plusDays(1).atTime(10, 0), origin + "加工厂", "工号" + random.nextInt(100), "完成清洗分拣", image);
                // Node 3: Quality Check (2 days later)
                jdbcTemplate.update(insertTraceSql, productId, "质量检测", catchDate.plusDays(2).atTime(14, 0), "质检中心", "质检员" + random.nextInt(10), "各项指标合格", image);
                // Node 4: Warehousing (3 days later)
                jdbcTemplate.update(insertTraceSql, productId, "入库仓储", catchDate.plusDays(3).atTime(9, 0), "冷链仓库", "库管" + random.nextInt(20), "入库保存", image);
            }
            logger.info("Generated 50 products with trace records.");
        }

        // 8.2 Orders (Ensure fresh dates for Dashboard)
        Integer orderCount = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM oms_order", Integer.class);
        if (orderCount != null && orderCount == 0) {
            logger.info("Generating mock orders with FRESH dates...");
            String insertOrderSql = "INSERT INTO oms_order (order_sn, user_id, total_amount, status, create_time, receiver_name, receiver_phone, receiver_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            
            LocalDateTime now = LocalDateTime.now();
            
            // Generate 30 orders
            for (int i = 0; i < 30; i++) {
                String sn = "ORD" + System.currentTimeMillis() + i;
                long userId = 2;
                BigDecimal amount = new BigDecimal(random.nextInt(2000) + 100);
                int status = random.nextInt(4); // 0-3
                
                // Distribute dates:
                // 10 orders TODAY (for Dashboard "Today" stats)
                // 20 orders in past 7 days (for "Trend" chart)
                LocalDateTime createTime;
                if (i < 10) {
                    createTime = now.minusHours(random.nextInt(12)); // Today
                    status = random.nextInt(3) + 1; // 1,2,3 (Paid/Shipped/Completed) for Sales stats
                } else {
                    createTime = now.minusDays(random.nextInt(6) + 1).minusHours(random.nextInt(12));
                }
                
                jdbcTemplate.update(insertOrderSql, sn, userId, amount, status, createTime, "张三", "13800138000", "北京市朝阳区");
            }
            logger.info("Generated 30 fresh orders.");
        }
    }
}
