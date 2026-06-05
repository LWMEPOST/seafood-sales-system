package com.seafood.dto;

import lombok.Data;
import java.math.BigDecimal;
import java.util.List;

@Data
public class DashboardStatsDTO {
    private BigDecimal todaySales;
    private Integer todayOrders;
    private Integer stockAlertCount;
    private Integer activeUsers;
    
    // New fields
    private Integer pendingPaymentCount; // Status 0
    private Integer toShipCount;         // Status 1
    private BigDecimal totalSales;       // All time sales
    
    private List<ChartData> salesTrend;
    private List<HeatmapData> stockHeatmap;
    
    @Data
    public static class ChartData {
        private String date;
        private BigDecimal value;
    }

    @Data
    public static class HeatmapData {
        private Integer x; // category index
        private Integer y; // region index
        private Integer value; // stock level
    }
}
