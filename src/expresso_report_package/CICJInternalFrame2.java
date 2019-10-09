/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package expresso_report_package;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author User01
 */
public class CICJInternalFrame2 extends javax.swing.JInternalFrame {

    /**
     * Creates new form CICJInternalFrame
     */
    private static String providerCode;
    private static String refDate;
    private static String genrefDate;
    private static String refVersion;
    private static Integer submissionType;
    private static String providerComment;
    private static String curr_dir;
    private static String repStartDate;
    private static String repCutOffDate;
    
    public CICJInternalFrame2() throws SQLException, IOException {
            Connection conn = ConnectionManager.getConnection();
            System.out.println(conn);
            
            try (Statement st1 = conn.createStatement()) {
                String sql1;
                sql1 = "select param_value,(select to_char(run_date,'DDMMYYYY') from branch where id=1),to_char(current_timestamp,'YYYYMMDDhh24miss') from institution where param_code='GEN.10244';";
                try (ResultSet rs1 = st1.executeQuery(sql1)) {
                    while (rs1.next())
                    {
                        providerCode = rs1.getString(1);
                        refDate = rs1.getString(2);
                        genrefDate = rs1.getString(3);
                    }
                }
            }
        initComponents();
        this.lbl_provider_code.setText(providerCode);
        this.lbl_refereceDate.setText(refDate);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        cmbVersion = new javax.swing.JComboBox();
        cmbSubmissionType = new javax.swing.JComboBox();
        jScrollPane1 = new javax.swing.JScrollPane();
        txtProviderComments = new javax.swing.JTextArea();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jButton1 = new javax.swing.JButton();
        jButton2 = new javax.swing.JButton();
        lbl_provider_code = new javax.swing.JLabel();
        lbl_refereceDate = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        txtbox_startdate = new javax.swing.JTextField();
        txtbox_cutoffdate = new javax.swing.JTextField();

        setClosable(true);
        setTitle("CIC Report");

        jLabel1.setText("Reference Date:");

        jLabel2.setText("Version:");

        cmbVersion.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "1.0" }));

        cmbSubmissionType.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "0 - Standard", "1 - Correction/History " }));

        txtProviderComments.setColumns(20);
        txtProviderComments.setRows(5);
        jScrollPane1.setViewportView(txtProviderComments);

        jLabel3.setText("Submission Type: ");

        jLabel4.setText("Provider Comments: ");

        jLabel5.setText("Provider Code:");

        jButton1.setText("Generate");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        jButton2.setText("Cancel");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        lbl_provider_code.setText("BNK1234");

        lbl_refereceDate.setText("DDMMYYYY");

        jLabel6.setText("Report Start Date:");

        jLabel7.setText("Report Cut-Off Date:");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addComponent(jButton2)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(jButton1))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel4)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jLabel1)
                                    .addComponent(jLabel2)
                                    .addComponent(jLabel3)
                                    .addComponent(jLabel5)
                                    .addComponent(jLabel6)
                                    .addComponent(jLabel7))
                                .addGap(31, 31, 31)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                                    .addComponent(cmbSubmissionType, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(cmbVersion, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(lbl_provider_code, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(lbl_refereceDate, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(txtbox_startdate)
                                    .addComponent(txtbox_cutoffdate))))
                        .addGap(0, 117, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(14, 14, 14)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5)
                    .addComponent(lbl_provider_code))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(lbl_refereceDate))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel6)
                    .addComponent(txtbox_startdate, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel7)
                    .addComponent(txtbox_cutoffdate, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(cmbVersion, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cmbSubmissionType, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel3))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jLabel4)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jButton1)
                    .addComponent(jButton2))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        this.dispose();
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed

        try {
            Connection conn = ConnectionManager.getConnection();
            System.out.println(conn);
            
            curr_dir = new java.io.File( "." ).getCanonicalPath();
            File CICFile = new File(curr_dir+"\\output\\"+providerCode+"_CSDF_"+genrefDate+".txt");
            
            
            
            //try (PrintWriter output = new PrintWriter(CICFile)){
                //providerCode = this.txtProviderCode.getText().toUpperCase();
                //SimpleDateFormat formater = new SimpleDateFormat("ddMMyyyy");
                //String dt1=formater.format(this.dateRefDate.getDate());
                //System.out.println(dt1);
            try (Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(CICFile), "UTF-8"))){

                refVersion = this.cmbVersion.getSelectedItem().toString().toUpperCase();
                submissionType = this.cmbSubmissionType.getSelectedIndex();
                providerComment = this.txtProviderComments.getText().toUpperCase();
                repStartDate = this.txtbox_startdate.getText();
                repCutOffDate = this.txtbox_cutoffdate.getText();
                
                try {
                    try (Statement st = conn.createStatement()) {
                        String sql;
                        sql = "select create_cic_report_2('"+providerCode+"', '"+refDate+"', cast('"+repStartDate+"' as date), cast('"+repCutOffDate+"' as date) , '"+refVersion+"', '"+submissionType+"', '"+providerComment+"');";
                        ResultSet rs = st.executeQuery(sql);
                        while (rs.next())
                        {
                            out.write(rs.getString(1)+"\n");
                        }
                        rs.close();
                    }
                    } catch (SQLException ex) {
                    Logger.getLogger(CICJInternalFrame2.class.getName()).log(Level.SEVERE, null, ex);
                }finally {
                    out.close();
                }
                JOptionPane.showMessageDialog(this,"CIC Report Complete.");
                this.dispose();
            }
            
        } catch (IOException | SQLException ex) {
            Logger.getLogger(CICJInternalFrame2.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }//GEN-LAST:event_jButton1ActionPerformed


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JComboBox cmbSubmissionType;
    private javax.swing.JComboBox cmbVersion;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JLabel lbl_provider_code;
    private javax.swing.JLabel lbl_refereceDate;
    private javax.swing.JTextArea txtProviderComments;
    private javax.swing.JTextField txtbox_cutoffdate;
    private javax.swing.JTextField txtbox_startdate;
    // End of variables declaration//GEN-END:variables
}