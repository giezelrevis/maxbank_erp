/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author User01
 */
public class CreateReport {
     public static String getReportTemplate(String ReportCode) throws SQLException, IOException{
        //Connection conn = ConnectionManager.getConnection("jdbc:postgresql://localhost:5433/", "NRBSL_DB", "org.postgresql.Driver", "postgres", "postgres");
        Connection conn = ConnectionManager.getConnection();
        System.out.println(conn);
        
        String excel_template;      
        try (Statement st = conn.createStatement()) {
            String sql;
            String repcode = ReportCode;
            excel_template = null;
            sql = "select template_path from report_template where rep_code = '" + repcode +"';";
            try ( //st.execute(sql);
                    ResultSet rs = st.executeQuery(sql)) {
                while (rs.next())
                {
                    excel_template = rs.getString(1);
                    System.out.println(excel_template);
                }
            }
         }
        System.out.println("This is on excell template ");
        return excel_template;
        //openExcelTemplate(excel_template, ReportCode);
    }
    public static String getReportQueryFSConso(String cutOffDate,String prevDayDate) throws SQLException, IOException{
            String sqlQuery = "";
            sqlQuery = " with X as ( ";
            sqlQuery += " select A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += "left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " and B.ref_date = '"+prevDayDate+"' and B.currency_id = 1 ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name ), ";
            sqlQuery += " Y as ( ";

            sqlQuery += " select ";
            sqlQuery += " A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 and b.batch_id not ilike 'PHP-EOY-%' ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name), ";
            sqlQuery += " Z as ( ";

            sqlQuery += " select ";
            sqlQuery += " A.code as code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " left outer join gl_txn_file B on A.code = B.gl_account_code ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 and b.batch_id not ilike 'PHP-EOY-%' ";
            sqlQuery += " where A.ref_date = '"+cutOffDate+"' and A.branch_id = 1 ";
            sqlQuery += " group by A.code,A.name ";
            sqlQuery += " order by A.code,A.name), ";
            sqlQuery += " U as ( ";

            sqlQuery += " select code as gl_code, sum(debit_balance-credit_balance) as xbal ";
            sqlQuery += " from gl_daily_file where ref_date = '"+prevDayDate+"' and currency_id = 1 ";
            sqlQuery += " group by code ";
            sqlQuery += " order by code) ";

            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, ";
            sqlQuery += " 'GL' || A.sort_code as gl, ";
            sqlQuery += " A.sort_name, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0 ";
            sqlQuery += " then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else 0 end as debit, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end < 0 ";
            sqlQuery += " then abs(X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end) else 0 end as credit ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " inner join X on A.sort_code = X.sort_code ";
            sqlQuery += " left outer join Y on A.sort_code = Y.sort_code ";
            sqlQuery += " where A.sort_code in (select account from fs_control_account where status_id = 2) ";
            sqlQuery += " union ";

            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, 'GL' || A.code as gl, A.name, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end >= 0 then ";
            sqlQuery += " U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end else 0 end, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end < 0 then ";
            sqlQuery += " abs(U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end) else 0 end ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " inner join U on A.code = U.gl_code ";
            sqlQuery += " left outer join Z on A.code = Z.code ";
            sqlQuery += " where A.code in (select account from fs_control_account where status_id = 2) and A.ref_date = '"+prevDayDate+"' and A.branch_id = 1 ";
            sqlQuery += " order by gl ";
         return sqlQuery;
    }
    public static String getReportQueryFSPerBranch(String cutOffDate,String prevDayDate,String branchId) throws SQLException, IOException{
            String sqlQuery = "";
            
            sqlQuery = " with X as (select A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " and B.ref_date = '"+prevDayDate+"' and B.currency_id = 1 and B.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name ), ";
            sqlQuery += " Y as (select ";
            sqlQuery += " A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and b.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name), ";
            sqlQuery += " Z as (select ";
            sqlQuery += " A.code as code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " left outer join gl_txn_file B on A.code = B.gl_account_code ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and B.branch_id = "+branchId+" ";
            sqlQuery += " where A.ref_date = '"+cutOffDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += "  group by A.code,A.name ";
            sqlQuery += " order by A.code,A.name), ";
            sqlQuery += " U as (select code as gl_code, debit_balance-credit_balance as xbal ";
            sqlQuery += " from gl_daily_file where ref_date = '"+prevDayDate+"' and currency_id = 1 and branch_id = "+branchId+" ";
            sqlQuery += " order by code) ";
            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, ";
            sqlQuery += " 'GL' || A.sort_code as gl, ";
            sqlQuery += " A.sort_name, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0 ";
            sqlQuery += " then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else 0 end as debit, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end < 0 ";
            sqlQuery += " then abs(X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end) else 0 end as credit ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " inner join X on A.sort_code = X.sort_code ";
            sqlQuery += " left outer join Y on A.sort_code = Y.sort_code ";
            sqlQuery += " where A.sort_code in (select account from fs_control_account where status_id = 2) ";
            sqlQuery += " union ";

            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, 'GL' || A.code as gl, A.name, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end >= 0 then ";
            sqlQuery += " U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end else 0 end, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end < 0 then ";
            sqlQuery += " abs(U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end) else 0 end ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " inner join U on A.code = U.gl_code ";
            sqlQuery += " left outer join Z on A.code = Z.code ";
            sqlQuery += " where A.code in (select account from fs_control_account where status_id = 2) and A.ref_date = '"+prevDayDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += " order by gl ";

         return sqlQuery;
    }
    public static String getReportQueryFSConsoPrevMonth(String prevMonthOfCutOffDate,String prevDayOfPrevMonthDate) throws SQLException, IOException{
            String sqlQuery = "";
            sqlQuery = " with X as ( ";
            sqlQuery += " select A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += "left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " and B.ref_date = '"+prevDayOfPrevMonthDate+"' and B.currency_id = 1 ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name ), ";
            sqlQuery += " Y as ( ";

            sqlQuery += " select ";
            sqlQuery += " A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+prevMonthOfCutOffDate+"' and b.txn_value_date <= '"+prevMonthOfCutOffDate+"' and C.currency_id = 1 and b.batch_id not ilike 'PHP-EOY-%' ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name), ";
            sqlQuery += " Z as ( ";

            sqlQuery += " select ";
            sqlQuery += " A.code as code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " left outer join gl_txn_file B on A.code = B.gl_account_code ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+prevMonthOfCutOffDate+"' and b.txn_value_date <= '"+prevMonthOfCutOffDate+"' and C.currency_id = 1 and b.batch_id not ilike 'PHP-EOY-%' ";
            sqlQuery += " where A.ref_date = '"+prevMonthOfCutOffDate+"' and A.branch_id = 1 ";
            sqlQuery += " group by A.code,A.name ";
            sqlQuery += " order by A.code,A.name), ";
            sqlQuery += " U as ( ";

            sqlQuery += " select code as gl_code, sum(debit_balance-credit_balance) as xbal ";
            sqlQuery += " from gl_daily_file where ref_date = '"+prevDayOfPrevMonthDate+"' and currency_id = 1 ";
            sqlQuery += " group by code ";
            sqlQuery += " order by code) ";

            sqlQuery += " select cast('"+prevMonthOfCutOffDate+"' as date) as ref_date, ";
            sqlQuery += " 'GL' || A.sort_code as gl, ";
            sqlQuery += " A.sort_name, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0 ";
            sqlQuery += " then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else 0 end as debit, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end < 0 ";
            sqlQuery += " then abs(X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end) else 0 end as credit ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " inner join X on A.sort_code = X.sort_code ";
            sqlQuery += " left outer join Y on A.sort_code = Y.sort_code ";
            sqlQuery += " where A.sort_code in (select account from fs_control_account where status_id = 2) ";
            sqlQuery += " union ";

            sqlQuery += " select cast('"+prevMonthOfCutOffDate+"' as date) as ref_date, 'GL' || A.code as gl, A.name, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end >= 0 then ";
            sqlQuery += " U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end else 0 end, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end < 0 then ";
            sqlQuery += " abs(U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end) else 0 end ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " inner join U on A.code = U.gl_code ";
            sqlQuery += " left outer join Z on A.code = Z.code ";
            sqlQuery += " where A.code in (select account from fs_control_account where status_id = 2) and A.ref_date = '"+prevDayOfPrevMonthDate+"' and A.branch_id = 1 ";
            sqlQuery += " order by gl ";
         return sqlQuery;
    }
    public static String getReportQueryFSConsoPrevYear(String prevYearDate,String prevDayOfPrevYear) throws SQLException, IOException{
            String sqlQuery = "";
            sqlQuery = " with X as ( ";
            sqlQuery += " select A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += "left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " and B.ref_date = '"+prevDayOfPrevYear+"' and B.currency_id = 1 ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name ), ";
            sqlQuery += " Y as ( ";

            sqlQuery += " select ";
            sqlQuery += " A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+prevYearDate+"' and b.txn_value_date <= '"+prevYearDate+"' and C.currency_id = 1 and b.batch_id not ilike 'PHP-EOY-%' ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name), ";
            sqlQuery += " Z as ( ";

            sqlQuery += " select ";
            sqlQuery += " A.code as code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " left outer join gl_txn_file B on A.code = B.gl_account_code ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+prevYearDate+"' and b.txn_value_date <= '"+prevYearDate+"' and C.currency_id = 1 and b.batch_id not ilike 'PHP-EOY-%' ";
            sqlQuery += " where A.ref_date = '"+prevYearDate+"' and A.branch_id = 1 ";
            sqlQuery += " group by A.code,A.name ";
            sqlQuery += " order by A.code,A.name), ";
            sqlQuery += " U as ( ";

            sqlQuery += " select code as gl_code, sum(debit_balance-credit_balance) as xbal ";
            sqlQuery += " from gl_daily_file where ref_date = '"+prevDayOfPrevYear+"' and currency_id = 1 ";
            sqlQuery += " group by code ";
            sqlQuery += " order by code) ";

            sqlQuery += " select cast('"+prevYearDate+"' as date) as ref_date, ";
            sqlQuery += " 'GL' || A.sort_code as gl, ";
            sqlQuery += " A.sort_name, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0 ";
            sqlQuery += " then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else 0 end as debit, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end < 0 ";
            sqlQuery += " then abs(X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end) else 0 end as credit ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " inner join X on A.sort_code = X.sort_code ";
            sqlQuery += " left outer join Y on A.sort_code = Y.sort_code ";
            sqlQuery += " where A.sort_code in (select account from fs_control_account where status_id = 2) ";
            sqlQuery += " union ";

            sqlQuery += " select cast('"+prevYearDate+"' as date) as ref_date, 'GL' || A.code as gl, A.name, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end >= 0 then ";
            sqlQuery += " U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end else 0 end, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end < 0 then ";
            sqlQuery += " abs(U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end) else 0 end ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " inner join U on A.code = U.gl_code ";
            sqlQuery += " left outer join Z on A.code = Z.code ";
            sqlQuery += " where A.code in (select account from fs_control_account where status_id = 2) and A.ref_date = '"+prevDayOfPrevYear+"' and A.branch_id = 1 ";
            sqlQuery += " order by gl ";
         return sqlQuery;
    }
    public static String getReportQueryFSComparativePerBranch(String cutOffDate,String prevDayDate,String branchId) throws SQLException, IOException{
            String sqlQuery = "";
            
            sqlQuery = " with X as (select A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " and B.ref_date = '"+prevDayDate+"' and B.currency_id = 1 and B.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name ), ";
            sqlQuery += " Y as (select ";
            sqlQuery += " A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and b.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name), ";
            sqlQuery += " Z as (select ";
            sqlQuery += " A.code as code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " left outer join gl_txn_file B on A.code = B.gl_account_code ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and B.branch_id = "+branchId+" ";
            sqlQuery += " where A.ref_date = '"+cutOffDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += "  group by A.code,A.name ";
            sqlQuery += " order by A.code,A.name), ";
            sqlQuery += " U as (select code as gl_code, debit_balance-credit_balance as xbal ";
            sqlQuery += " from gl_daily_file where ref_date = '"+prevDayDate+"' and currency_id = 1 and branch_id = "+branchId+" ";
            sqlQuery += " order by code) ";
            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, ";
            sqlQuery += " 'GL' || A.sort_code as gl, ";
            sqlQuery += " A.sort_name, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0 ";
            sqlQuery += " then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else 0 end as debit, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end < 0 ";
            sqlQuery += " then abs(X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end) else 0 end as credit ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " inner join X on A.sort_code = X.sort_code ";
            sqlQuery += " left outer join Y on A.sort_code = Y.sort_code ";
            sqlQuery += " where A.sort_code in (select account from fs_control_account where status_id = 2) ";
            sqlQuery += " union ";

            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, 'GL' || A.code as gl, A.name, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end >= 0 then ";
            sqlQuery += " U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end else 0 end, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end < 0 then ";
            sqlQuery += " abs(U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end) else 0 end ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " inner join U on A.code = U.gl_code ";
            sqlQuery += " left outer join Z on A.code = Z.code ";
            sqlQuery += " where A.code in (select account from fs_control_account where status_id = 2) and A.ref_date = '"+prevDayDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += " order by gl ";

         return sqlQuery;
    }
    public static String getReportQueryFSComparativePrevMonthPerBranch(String cutOffDate,String prevDayDate,String branchId) throws SQLException, IOException{
            String sqlQuery = "";
            
            sqlQuery = " with X as (select A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " and B.ref_date = '"+prevDayDate+"' and B.currency_id = 1 and B.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name ), ";
            sqlQuery += " Y as (select ";
            sqlQuery += " A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and b.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name), ";
            sqlQuery += " Z as (select ";
            sqlQuery += " A.code as code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " left outer join gl_txn_file B on A.code = B.gl_account_code ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and B.branch_id = "+branchId+" ";
            sqlQuery += " where A.ref_date = '"+cutOffDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += "  group by A.code,A.name ";
            sqlQuery += " order by A.code,A.name), ";
            sqlQuery += " U as (select code as gl_code, debit_balance-credit_balance as xbal ";
            sqlQuery += " from gl_daily_file where ref_date = '"+prevDayDate+"' and currency_id = 1 and branch_id = "+branchId+" ";
            sqlQuery += " order by code) ";
            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, ";
            sqlQuery += " 'GL' || A.sort_code as gl, ";
            sqlQuery += " A.sort_name, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0 ";
            sqlQuery += " then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else 0 end as debit, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end < 0 ";
            sqlQuery += " then abs(X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end) else 0 end as credit ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " inner join X on A.sort_code = X.sort_code ";
            sqlQuery += " left outer join Y on A.sort_code = Y.sort_code ";
            sqlQuery += " where A.sort_code in (select account from fs_control_account where status_id = 2) ";
            sqlQuery += " union ";

            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, 'GL' || A.code as gl, A.name, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end >= 0 then ";
            sqlQuery += " U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end else 0 end, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end < 0 then ";
            sqlQuery += " abs(U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end) else 0 end ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " inner join U on A.code = U.gl_code ";
            sqlQuery += " left outer join Z on A.code = Z.code ";
            sqlQuery += " where A.code in (select account from fs_control_account where status_id = 2) and A.ref_date = '"+prevDayDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += " order by gl ";

         return sqlQuery;
    }
    public static String getReportQueryFSComparativePrevYearPerBranch(String cutOffDate,String prevDayDate,String branchId) throws SQLException, IOException{
            String sqlQuery = "";
            
            sqlQuery = " with X as (select A.sort_code as sort_code, round(sum(B.debit_balance - B.credit_balance),2) as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_daily_file B on A.sort_code = substring(B.code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " and B.ref_date = '"+prevDayDate+"' and B.currency_id = 1 and B.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name ), ";
            sqlQuery += " Y as (select ";
            sqlQuery += " A.sort_code as sort_code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " left outer join gl_txn_file B on A.sort_code = substring(B.gl_account_code from 1 for char_length(A.sort_code)) ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and b.branch_id = "+branchId+" ";
            sqlQuery += " group by A.sort_code,A.sort_name ";
            sqlQuery += " order by A.sort_code,A.sort_name), ";
            sqlQuery += " Z as (select ";
            sqlQuery += " A.code as code, case when round(sum(B.debit_amt - B.credit_amt),2) is null then 0 else round(sum(B.debit_amt - B.credit_amt),2) end as bal_amt ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " left outer join gl_txn_file B on A.code = B.gl_account_code ";
            sqlQuery += " inner join gl_account C on B.gl_account_id = C.id ";
            sqlQuery += " and b.txn_date >= '"+cutOffDate+"' and b.txn_value_date <= '"+cutOffDate+"' and C.currency_id = 1 ";
            sqlQuery += " and b.batch_id not ilike 'PHP-EOY-%' and B.branch_id = "+branchId+" ";
            sqlQuery += " where A.ref_date = '"+cutOffDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += "  group by A.code,A.name ";
            sqlQuery += " order by A.code,A.name), ";
            sqlQuery += " U as (select code as gl_code, debit_balance-credit_balance as xbal ";
            sqlQuery += " from gl_daily_file where ref_date = '"+prevDayDate+"' and currency_id = 1 and branch_id = "+branchId+" ";
            sqlQuery += " order by code) ";
            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, ";
            sqlQuery += " 'GL' || A.sort_code as gl, ";
            sqlQuery += " A.sort_name, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end >= 0 ";
            sqlQuery += " then X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end else 0 end as debit, ";
            sqlQuery += " case when X.bal_amt + ";
            sqlQuery += " case when Y.bal_amt is null then 0 else Y.bal_amt end < 0 ";
            sqlQuery += " then abs(X.bal_amt + case when Y.bal_amt is null then 0 else Y.bal_amt end) else 0 end as credit ";
            sqlQuery += " from gl_sort_code A ";
            sqlQuery += " inner join X on A.sort_code = X.sort_code ";
            sqlQuery += " left outer join Y on A.sort_code = Y.sort_code ";
            sqlQuery += " where A.sort_code in (select account from fs_control_account where status_id = 2) ";
            sqlQuery += " union ";

            sqlQuery += " select cast('"+cutOffDate+"' as date) as ref_date, 'GL' || A.code as gl, A.name, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end >= 0 then ";
            sqlQuery += " U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end else 0 end, ";
            sqlQuery += " case when U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end < 0 then ";
            sqlQuery += " abs(U.xbal + case when Z.bal_amt is null then 0 else Z.bal_amt end) else 0 end ";
            sqlQuery += " from gl_daily_file A ";
            sqlQuery += " inner join U on A.code = U.gl_code ";
            sqlQuery += " left outer join Z on A.code = Z.code ";
            sqlQuery += " where A.code in (select account from fs_control_account where status_id = 2) and A.ref_date = '"+prevDayDate+"' and A.branch_id = "+branchId+" ";
            sqlQuery += " order by gl ";

         return sqlQuery;
    }
}
