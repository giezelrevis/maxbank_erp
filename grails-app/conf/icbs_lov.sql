--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.4
-- Dumped by pg_dump version 9.3.4
-- Started on 2014-10-25 13:56:38 PHT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- TOC entry 2898 (class 0 OID 261219)
-- Dependencies: 170
-- Data for Name: acct_no_format; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO acct_no_format (id, version, code, description, status) VALUES (1, 1, '010', 'BBB-APP-SSSSS-D', true);
INSERT INTO acct_no_format (id, version, code, description, status) VALUES (2, 1, '020', 'BBB-PPP-SSSSS-D', true);
INSERT INTO acct_no_format (id, version, code, description, status) VALUES (3, 1, '030', 'BB-PPP-SSSSSS-D', true);


--
-- TOC entry 2899 (class 0 OID 261224)
-- Dependencies: 171
-- Data for Name: acct_to_acct_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO acct_to_acct_link (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO acct_to_acct_link (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO acct_to_acct_link (id, version, code, description, status) VALUES (3, 1, '990', 'Cancelled', true);
INSERT INTO acct_to_acct_link (id, version, code, description, status) VALUES (4, 1, '999', 'Removed', true);


--
-- TOC entry 2900 (class 0 OID 261237)
-- Dependencies: 172
-- Data for Name: address_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO address_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO address_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO address_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO address_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2901 (class 0 OID 261242)
-- Dependencies: 173
-- Data for Name: address_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO address_type (id, version, code, description, status) VALUES (1, 1, '010', 'Home', true);
INSERT INTO address_type (id, version, code, description, status) VALUES (2, 1, '020', 'Business', true);
INSERT INTO address_type (id, version, code, description, status) VALUES (3, 1, '030', 'Temporary', true);
INSERT INTO address_type (id, version, code, description, status) VALUES (4, 1, '040', 'Others', true);
INSERT INTO address_type (id, version, code, description, status) VALUES (5, 1, '999', 'Unknown', true);


--
-- TOC entry 2902 (class 0 OID 261255)
-- Dependencies: 174
-- Data for Name: attachment_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO attachment_type (id, version, code, description, status) VALUES (1, 1, '010', 'Photo', true);
INSERT INTO attachment_type (id, version, code, description, status) VALUES (2, 1, '020', 'Signature', true);
INSERT INTO attachment_type (id, version, code, description, status) VALUES (3, 1, '030', 'ID', true);
INSERT INTO attachment_type (id, version, code, description, status) VALUES (4, 1, '040', 'Document', true);
INSERT INTO attachment_type (id, version, code, description, status) VALUES (5, 1, '050', 'Others', true);


--
-- TOC entry 2903 (class 0 OID 261260)
-- Dependencies: 175
-- Data for Name: audit_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO audit_type (id, version, code, description, status) VALUES (1, 1, '010', 'Attempted Login', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (2, 1, '020', 'Successful Login', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (3, 1, '030', 'Admin and Config View', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (4, 1, '040', 'Admin and Config Amendment', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (5, 1, '050', 'Customer Information View', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (6, 1, '060', 'Customer Information Amendment', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (7, 1, '070', 'Deposit Account View', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (8, 1, '080', 'Deposit Account Amendment', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (9, 1, '090', 'Loan Account View', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (10, 1, '100', 'Loan Account Amendment', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (11, 1, '110', 'Teller Transaction', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (12, 1, '120', 'Teller Transaction View', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (13, 1, '130', 'General Ledger View', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (14, 1, '140', 'General Ledger Amendment', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (15, 1, '150', 'Periodic Process Initiation', true);
INSERT INTO audit_type (id, version, code, description, status) VALUES (16, 1, '160', 'Logout', true);


--
-- TOC entry 2904 (class 0 OID 261278)
-- Dependencies: 176
-- Data for Name: branch_run_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO branch_run_status (id, version, code, description, status) VALUES (1, 1, '100', 'Opened', true);
INSERT INTO branch_run_status (id, version, code, description, status) VALUES (2, 1, '910', 'Front Office Closed', true);
INSERT INTO branch_run_status (id, version, code, description, status) VALUES (3, 1, '920', 'All Transactions Closed', true);


--
-- TOC entry 2905 (class 0 OID 261283)
-- Dependencies: 177
-- Data for Name: branch_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO branch_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO branch_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO branch_status (id, version, code, description, status) VALUES (3, 1, '990', 'Cancelled/Removed', true);
INSERT INTO branch_status (id, version, code, description, status) VALUES (4, 1, '999', 'Closed', true);


--
-- TOC entry 2906 (class 0 OID 261298)
-- Dependencies: 178
-- Data for Name: certificate_time_deposit_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO certificate_time_deposit_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO certificate_time_deposit_status (id, version, code, description, status) VALUES (2, 1, '100', 'Issued', true);
INSERT INTO certificate_time_deposit_status (id, version, code, description, status) VALUES (3, 1, '990', 'Cancelled', true);
INSERT INTO certificate_time_deposit_status (id, version, code, description, status) VALUES (4, 1, '999', 'Removed', true);


--
-- TOC entry 2907 (class 0 OID 261303)
-- Dependencies: 179
-- Data for Name: check_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO check_status (id, version, code, description, status) VALUES (1, 1, '000', 'Un-issued', true);
INSERT INTO check_status (id, version, code, description, status) VALUES (2, 1, '100', 'Issued', true);
INSERT INTO check_status (id, version, code, description, status) VALUES (3, 1, '900', 'Used', true);
INSERT INTO check_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2908 (class 0 OID 261308)
-- Dependencies: 180
-- Data for Name: check_txn_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO check_txn_type (id, version, code, description, status) VALUES (1, 1, '000', 'N/A', true);
INSERT INTO check_txn_type (id, version, code, description, status) VALUES (2, 1, '010', 'Onus Encashment', true);
INSERT INTO check_txn_type (id, version, code, description, status) VALUES (3, 1, '020', 'Onus Deposit', true);
INSERT INTO check_txn_type (id, version, code, description, status) VALUES (4, 1, '030', 'Off-us Deposit', true);


--
-- TOC entry 2909 (class 0 OID 261336)
-- Dependencies: 181
-- Data for Name: config_item_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO config_item_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO config_item_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO config_item_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed/Deleted', true);
INSERT INTO config_item_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2910 (class 0 OID 261349)
-- Dependencies: 182
-- Data for Name: contact_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO contact_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO contact_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO contact_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO contact_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2911 (class 0 OID 261377)
-- Dependencies: 183
-- Data for Name: customer_attachment_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customer_attachment_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO customer_attachment_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO customer_attachment_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO customer_attachment_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2912 (class 0 OID 261382)
-- Dependencies: 184
-- Data for Name: customer_dosri_code; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customer_dosri_code (id, version, code, description, status) VALUES (1, 1, '000', 'Non-DOSRI', true);
INSERT INTO customer_dosri_code (id, version, code, description, status) VALUES (2, 1, '010', 'Director', true);
INSERT INTO customer_dosri_code (id, version, code, description, status) VALUES (3, 1, '020', 'Officer', true);
INSERT INTO customer_dosri_code (id, version, code, description, status) VALUES (4, 1, '030', 'Stock-Holder', true);
INSERT INTO customer_dosri_code (id, version, code, description, status) VALUES (5, 1, '040', 'Related Interest', true);
INSERT INTO customer_dosri_code (id, version, code, description, status) VALUES (6, 1, '050', 'Employee', true);


--
-- TOC entry 2913 (class 0 OID 261392)
-- Dependencies: 185
-- Data for Name: customer_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customer_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO customer_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO customer_status (id, version, code, description, status) VALUES (3, 1, '910', 'Locked', true);
INSERT INTO customer_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);
INSERT INTO customer_status (id, version, code, description, status) VALUES (5, 1, '100', 'Incomplete', true);


--
-- TOC entry 2914 (class 0 OID 261397)
-- Dependencies: 186
-- Data for Name: customer_to_acct_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customer_to_acct_link (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO customer_to_acct_link (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO customer_to_acct_link (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO customer_to_acct_link (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2969 (class 0 OID 297211)
-- Dependencies: 241
-- Data for Name: customer_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO customer_type (id, version, code, description, status) VALUES (1, 1, '010', 'Individual', true);
INSERT INTO customer_type (id, version, code, description, status) VALUES (2, 1, '020', 'Partnership', true);
INSERT INTO customer_type (id, version, code, description, status) VALUES (3, 1, '030', 'Corporation', true);
INSERT INTO customer_type (id, version, code, description, status) VALUES (4, 1, '100', 'Linked', true);

--
-- TOC entry 2915 (class 0 OID 261402)
-- Dependencies: 187
-- Data for Name: deposit_acct_dormancy_transfer_freq; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO deposit_acct_dormancy_transfer_freq (id, version, code, description, status) VALUES (1, 1, '010', 'Daily', true);
INSERT INTO deposit_acct_dormancy_transfer_freq (id, version, code, description, status) VALUES (2, 1, '020', 'Monthly', true);
INSERT INTO deposit_acct_dormancy_transfer_freq (id, version, code, description, status) VALUES (3, 1, '030', 'Quarterly', true);
INSERT INTO deposit_acct_dormancy_transfer_freq (id, version, code, description, status) VALUES (4, 1, '040', 'Semi-Annually', true);
INSERT INTO deposit_acct_dormancy_transfer_freq (id, version, code, description, status) VALUES (5, 1, '050', 'Anually', true);


--
-- TOC entry 2916 (class 0 OID 261407)
-- Dependencies: 188
-- Data for Name: deposit_capitalization_freq; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO deposit_capitalization_freq (id, version, code, description, status) VALUES (1, 1, '010', 'Monthly', true);
INSERT INTO deposit_capitalization_freq (id, version, code, description, status) VALUES (2, 1, '020', 'Quarterly', true);
INSERT INTO deposit_capitalization_freq (id, version, code, description, status) VALUES (3, 1, '030', 'Semi-Annually', true);
INSERT INTO deposit_capitalization_freq (id, version, code, description, status) VALUES (4, 1, '040', 'Annually', true);


--
-- TOC entry 2917 (class 0 OID 261412)
-- Dependencies: 189
-- Data for Name: deposit_interest_calculation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO deposit_interest_calculation (id, version, code, description, status) VALUES (1, 1, '010', 'Average Daily Balance', true);
INSERT INTO deposit_interest_calculation (id, version, code, description, status) VALUES (2, 1, '020', 'Actual Daily Balance', true);
INSERT INTO deposit_interest_calculation (id, version, code, description, status) VALUES (3, 1, '030', 'Minimum Monthly Balance', true);
INSERT INTO deposit_interest_calculation (id, version, code, description, status) VALUES (4, 1, '040', 'Minimum Quarterly Balance', true);


--
-- TOC entry 2918 (class 0 OID 261417)
-- Dependencies: 190
-- Data for Name: deposit_interest_start; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO deposit_interest_start (id, version, code, description, status) VALUES (1, 1, '010', 'On Deposit Date', true);
INSERT INTO deposit_interest_start (id, version, code, description, status) VALUES (2, 1, '020', 'On Clearing Date', true);
INSERT INTO deposit_interest_start (id, version, code, description, status) VALUES (3, 1, '030', 'On Clearing Date + 1', true);


--
-- TOC entry 2919 (class 0 OID 261422)
-- Dependencies: 191
-- Data for Name: deposit_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO deposit_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO deposit_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO deposit_status (id, version, code, description, status) VALUES (3, 1, '020', 'Re-Activated', true);
INSERT INTO deposit_status (id, version, code, description, status) VALUES (4, 1, '030', 'Re-Opened', true);
INSERT INTO deposit_status (id, version, code, description, status) VALUES (5, 1, '900', 'Dormant', true);
INSERT INTO deposit_status (id, version, code, description, status) VALUES (6, 1, '910', 'Locked/Frozen', true);
INSERT INTO deposit_status (id, version, code, description, status) VALUES (7, 1, '990', 'Closed', true);
INSERT INTO deposit_status (id, version, code, description, status) VALUES (8, 1, '999', 'Cancelled', true);


--
-- TOC entry 2920 (class 0 OID 261427)
-- Dependencies: 192
-- Data for Name: deposit_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO deposit_type (id, version, code, description, status) VALUES (1, 1, '010', 'Savings Account', true);
INSERT INTO deposit_type (id, version, code, description, status) VALUES (2, 1, '020', 'Current Account', true);
INSERT INTO deposit_type (id, version, code, description, status) VALUES (3, 1, '030', 'Fixed/Time Deposit', true);
INSERT INTO deposit_type (id, version, code, description, status) VALUES (4, 1, '040', 'Bills Payable', true);
INSERT INTO deposit_type (id, version, code, description, status) VALUES (5, 1, '050', 'Other Payables', true);


--
-- TOC entry 2921 (class 0 OID 261432)
-- Dependencies: 193
-- Data for Name: designation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO designation (id, version, code, description, status) VALUES (1, 1, '010', 'Administrator', true);
INSERT INTO designation (id, version, code, description, status) VALUES (2, 1, '020', 'Teller/Cashier', true);
INSERT INTO designation (id, version, code, description, status) VALUES (3, 1, '030', 'Accounting', true);
INSERT INTO designation (id, version, code, description, status) VALUES (4, 1, '040', 'Audit', true);
INSERT INTO designation (id, version, code, description, status) VALUES (5, 1, '050', 'Management', true);
INSERT INTO designation (id, version, code, description, status) VALUES (6, 1, '060', 'Others', true);


--
-- TOC entry 2922 (class 0 OID 261437)
-- Dependencies: 194
-- Data for Name: doc_inventory_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO doc_inventory_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO doc_inventory_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO doc_inventory_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO doc_inventory_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2923 (class 0 OID 261442)
-- Dependencies: 195
-- Data for Name: doc_inventory_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO doc_inventory_type (id, version, code, description, status) VALUES (1, 1, '010', 'Certificate of Time Deposit', true);
INSERT INTO doc_inventory_type (id, version, code, description, status) VALUES (2, 1, '020', 'Passbook', true);
INSERT INTO doc_inventory_type (id, version, code, description, status) VALUES (3, 1, '030', 'Check', true);
INSERT INTO doc_inventory_type (id, version, code, description, status) VALUES (4, 1, '040', 'Cashier''s Check', true);
INSERT INTO doc_inventory_type (id, version, code, description, status) VALUES (5, 1, '050', 'Official Receipt', true);
INSERT INTO doc_inventory_type (id, version, code, description, status) VALUES (6, 1, '060', 'Promissory Note', true);


--
-- TOC entry 2924 (class 0 OID 261471)
-- Dependencies: 196
-- Data for Name: fd_pre_termination_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO fd_pre_termination_type (id, version, code, description, status) VALUES (1, 1, '010', 'Single Payment', true);
INSERT INTO fd_pre_termination_type (id, version, code, description, status) VALUES (2, 1, '020', 'Installment', true);
INSERT INTO fd_pre_termination_type (id, version, code, description, status) VALUES (3, 1, '030', 'Installment - Balloon', true);
INSERT INTO fd_pre_termination_type (id, version, code, description, status) VALUES (4, 1, '040', 'Installment - Embedded Interest', true);
INSERT INTO fd_pre_termination_type (id, version, code, description, status) VALUES (5, 1, '050', 'Installment - Manual', true);


--
-- TOC entry 2925 (class 0 OID 261476)
-- Dependencies: 197
-- Data for Name: gender; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO gender (id, version, code, description, status) VALUES (1, 1, '000', 'N/A', true);
INSERT INTO gender (id, version, code, description, status) VALUES (2, 1, '00M', 'Male', true);
INSERT INTO gender (id, version, code, description, status) VALUES (3, 1, '00F', 'Female', true);
INSERT INTO gender (id, version, code, description, status) VALUES (4, 1, '900', 'Others', true);


--
-- TOC entry 2926 (class 0 OID 261481)
-- Dependencies: 198
-- Data for Name: gl_acct_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO gl_acct_type (id, version, code, description, status) VALUES (1, 1, '010', 'Asset', true);
INSERT INTO gl_acct_type (id, version, code, description, status) VALUES (2, 1, '020', 'Liability', true);
INSERT INTO gl_acct_type (id, version, code, description, status) VALUES (3, 1, '030', 'Capital', true);
INSERT INTO gl_acct_type (id, version, code, description, status) VALUES (4, 1, '040', 'Income', true);
INSERT INTO gl_acct_type (id, version, code, description, status) VALUES (5, 1, '050', 'Expenses', true);
INSERT INTO gl_acct_type (id, version, code, description, status) VALUES (6, 1, '060', 'Contingent', true);
INSERT INTO gl_acct_type (id, version, code, description, status) VALUES (7, 1, '900', 'Unspecified', true);


--
-- TOC entry 2927 (class 0 OID 261486)
-- Dependencies: 199
-- Data for Name: gl_sub_acct_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2974 (class 0 OID 0)
-- Dependencies: 233
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('hibernate_sequence', 2, true);


--
-- TOC entry 2928 (class 0 OID 261491)
-- Dependencies: 200
-- Data for Name: hold_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO hold_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO hold_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO hold_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO hold_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2929 (class 0 OID 261496)
-- Dependencies: 201
-- Data for Name: hold_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO hold_type (id, version, code, description, status) VALUES (1, 1, '010', 'Fixed Amount', true);
INSERT INTO hold_type (id, version, code, description, status) VALUES (2, 1, '020', 'Variable Amount (Percentage)', true);
INSERT INTO hold_type (id, version, code, description, status) VALUES (3, 1, '030', 'Variable Amount (Loan Account Back-to-Back)', true);


--
-- TOC entry 2930 (class 0 OID 261519)
-- Dependencies: 202
-- Data for Name: interest_payment_mode; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO interest_payment_mode (id, version, code, description, status) VALUES (1, 1, '010', 'Withdrawable from Account', true);
INSERT INTO interest_payment_mode (id, version, code, description, status) VALUES (2, 1, '020', 'Transfer to Deposit Account', true);
INSERT INTO interest_payment_mode (id, version, code, description, status) VALUES (3, 1, '030', 'Transfer to GL Account', true);
INSERT INTO interest_payment_mode (id, version, code, description, status) VALUES (4, 1, '900', 'Capitalize into FD/TD', true);


--
-- TOC entry 2931 (class 0 OID 261529)
-- Dependencies: 203
-- Data for Name: loan_acct_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_acct_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO loan_acct_status (id, version, code, description, status) VALUES (2, 1, '010', 'Opened', true);
INSERT INTO loan_acct_status (id, version, code, description, status) VALUES (3, 1, '020', 'Disbursed', true);
INSERT INTO loan_acct_status (id, version, code, description, status) VALUES (4, 1, '030', 'Matured', true);
INSERT INTO loan_acct_status (id, version, code, description, status) VALUES (5, 1, '900', 'Locked/Frozen', true);
INSERT INTO loan_acct_status (id, version, code, description, status) VALUES (6, 1, '990', 'Terminated/Closed', true);
INSERT INTO loan_acct_status (id, version, code, description, status) VALUES (7, 1, '999', 'Cancelled', true);


--
-- TOC entry 2932 (class 0 OID 261534)
-- Dependencies: 204
-- Data for Name: loan_advanced_interest_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_advanced_interest_type (id, version, code, description, status) VALUES (1, 1, '010', 'None', true);
INSERT INTO loan_advanced_interest_type (id, version, code, description, status) VALUES (2, 1, '020', 'Full', true);
INSERT INTO loan_advanced_interest_type (id, version, code, description, status) VALUES (3, 1, '030', 'Partial', true);


--
-- TOC entry 2933 (class 0 OID 261539)
-- Dependencies: 205
-- Data for Name: loan_application_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_application_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO loan_application_status (id, version, code, description, status) VALUES (2, 1, '010', 'Documents Complete', true);
INSERT INTO loan_application_status (id, version, code, description, status) VALUES (3, 1, '020', 'Processed', true);
INSERT INTO loan_application_status (id, version, code, description, status) VALUES (4, 1, '030', 'Credit Investigation Completed', true);
INSERT INTO loan_application_status (id, version, code, description, status) VALUES (5, 1, '040', 'Rejected by Credit Com', true);
INSERT INTO loan_application_status (id, version, code, description, status) VALUES (6, 1, '050', 'Approved by Credit Com', true);
INSERT INTO loan_application_status (id, version, code, description, status) VALUES (7, 1, '900', 'Locked/Frozen', true);
INSERT INTO loan_application_status (id, version, code, description, status) VALUES (8, 1, '999', 'Cancelled', true);


--
-- TOC entry 2934 (class 0 OID 261544)
-- Dependencies: 206
-- Data for Name: loan_calculation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_calculation (id, version, code, description, status) VALUES (1, 1, '010', 'Single Payment', true);
INSERT INTO loan_calculation (id, version, code, description, status) VALUES (2, 1, '020', 'Declining Fixed Principal', true);
INSERT INTO loan_calculation (id, version, code, description, status) VALUES (3, 1, '030', 'Annuity/Mortgage', true);
INSERT INTO loan_calculation (id, version, code, description, status) VALUES (4, 1, '040', 'Rule of 78', true);
INSERT INTO loan_calculation (id, version, code, description, status) VALUES (5, 1, '050', 'Straight/Flat', true);
INSERT INTO loan_calculation (id, version, code, description, status) VALUES (6, 1, '060', 'Manual', true);


--
-- TOC entry 2935 (class 0 OID 261549)
-- Dependencies: 207
-- Data for Name: loan_collateral_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_collateral_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO loan_collateral_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO loan_collateral_status (id, version, code, description, status) VALUES (3, 1, '020', 'Released', true);
INSERT INTO loan_collateral_status (id, version, code, description, status) VALUES (4, 1, '900', 'Removed', true);
INSERT INTO loan_collateral_status (id, version, code, description, status) VALUES (5, 1, '999', 'Cancelled', true);


--
-- TOC entry 2936 (class 0 OID 261554)
-- Dependencies: 208
-- Data for Name: loan_collateral_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_collateral_type (id, version, code, description, status) VALUES (1, 1, 'REM', 'Real Estate Mortgage', true);
INSERT INTO loan_collateral_type (id, version, code, description, status) VALUES (2, 1, 'CHT', 'Chattel Mortgage', true);
INSERT INTO loan_collateral_type (id, version, code, description, status) VALUES (3, 1, 'ACC', 'Account Holdout', true);
INSERT INTO loan_collateral_type (id, version, code, description, status) VALUES (4, 1, 'PDC', 'Post Dated Checks', true);
INSERT INTO loan_collateral_type (id, version, code, description, status) VALUES (5, 1, 'OTH', 'Others', true);


--
-- TOC entry 2962 (class 0 OID 273959)
-- Dependencies: 234
-- Data for Name: loan_deduction_special_calculation; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_deduction_special_calculation (id, version, code, description, status) VALUES (1, 1, '010', 'Manual', true);
INSERT INTO loan_deduction_special_calculation (id, version, code, description, status) VALUES (2, 1, '020', 'Documentary Stamp Tax (DST)', true);
INSERT INTO loan_deduction_special_calculation (id, version, code, description, status) VALUES (3, 1, '030', 'Gross Receipts Tax (GRT)', true);


--
-- TOC entry 2937 (class 0 OID 261559)
-- Dependencies: 209
-- Data for Name: loan_financial_info_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_financial_info_type (id, version, code, description, status) VALUES (1, 1, 'INC', 'Income', true);
INSERT INTO loan_financial_info_type (id, version, code, description, status) VALUES (2, 1, 'EXP', 'Expense', true);
INSERT INTO loan_financial_info_type (id, version, code, description, status) VALUES (3, 1, 'OTH', 'Others', true);


--
-- TOC entry 2938 (class 0 OID 261564)
-- Dependencies: 210
-- Data for Name: loan_freq; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_freq (id, version, code, description, status) VALUES (1, 1, '010', 'Daily', true);
INSERT INTO loan_freq (id, version, code, description, status) VALUES (2, 1, '020', 'Weekly (last day of week)', true);
INSERT INTO loan_freq (id, version, code, description, status) VALUES (3, 1, '030', 'Weekly (First day of week)', true);
INSERT INTO loan_freq (id, version, code, description, status) VALUES (4, 1, '040', 'Monthly', true);
INSERT INTO loan_freq (id, version, code, description, status) VALUES (5, 1, '050', 'Quarterly', true);
INSERT INTO loan_freq (id, version, code, description, status) VALUES (6, 1, '060', 'Semi-Annually', true);
INSERT INTO loan_freq (id, version, code, description, status) VALUES (7, 1, '070', 'Annually', true);


--
-- TOC entry 2963 (class 0 OID 273964)
-- Dependencies: 235
-- Data for Name: loan_installment_freq; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (1, 1, '010', 'Daily', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (2, 1, '020', 'Daily (No weekends)', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (3, 1, '030', 'Weekly', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (4, 1, '040', 'Bi-Weekly', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (5, 1, '050', 'Semi-Monthly (15 days)', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (6, 1, '060', 'Monthly (30 days)', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (7, 1, '070', 'Monthly', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (8, 1, '080', 'Bi-Monthly', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (9, 1, '090', 'Quarterly', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (10, 1, '100', 'Semi-Annually', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (11, 1, '110', 'Annually', true);
INSERT INTO loan_installment_freq (id, version, code, description, status) VALUES (12, 1, '120', 'Manual', true);


--
-- TOC entry 2939 (class 0 OID 261569)
-- Dependencies: 211
-- Data for Name: loan_installment_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_installment_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO loan_installment_status (id, version, code, description, status) VALUES (2, 1, '010', 'Approaching', true);
INSERT INTO loan_installment_status (id, version, code, description, status) VALUES (3, 1, '100', 'Due', true);
INSERT INTO loan_installment_status (id, version, code, description, status) VALUES (4, 1, '910', 'Partially Paid', true);
INSERT INTO loan_installment_status (id, version, code, description, status) VALUES (5, 1, '920', 'Fully Paid', true);


--
-- TOC entry 2940 (class 0 OID 261574)
-- Dependencies: 212
-- Data for Name: loan_installment_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_installment_type (id, version, code, description, status) VALUES (1, 1, '010', 'Single Payment', true);
INSERT INTO loan_installment_type (id, version, code, description, status) VALUES (2, 1, '020', 'Installment', true);
INSERT INTO loan_installment_type (id, version, code, description, status) VALUES (3, 1, '030', 'Installment - Balloon', true);
INSERT INTO loan_installment_type (id, version, code, description, status) VALUES (4, 1, '040', 'Installment - Embedded Interest', true);
INSERT INTO loan_installment_type (id, version, code, description, status) VALUES (5, 1, '050', 'Installment - Manual', true);


--
-- TOC entry 2941 (class 0 OID 261579)
-- Dependencies: 213
-- Data for Name: loan_penalty_basis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_penalty_basis (id, version, code, description, status) VALUES (1, 1, '010', 'Overdue Principal', true);
INSERT INTO loan_penalty_basis (id, version, code, description, status) VALUES (2, 1, '020', 'Overdue Principal + Interest', true);
INSERT INTO loan_penalty_basis (id, version, code, description, status) VALUES (3, 1, '030', 'Principal ', true);
INSERT INTO loan_penalty_basis (id, version, code, description, status) VALUES (4, 1, '040', 'Principal + Interest', true);


--
-- TOC entry 2942 (class 0 OID 261584)
-- Dependencies: 214
-- Data for Name: loan_penalty_freq; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_penalty_freq (id, version, code, description, status) VALUES (1, 1, '010', 'Daily', true);
INSERT INTO loan_penalty_freq (id, version, code, description, status) VALUES (2, 1, '020', 'Weekly', true);
INSERT INTO loan_penalty_freq (id, version, code, description, status) VALUES (3, 1, '030', 'Monthly', true);


--
-- TOC entry 2964 (class 0 OID 273969)
-- Dependencies: 236
-- Data for Name: loan_service_charge_basis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_service_charge_basis (id, version, code, description, status) VALUES (1, 1, '010', 'Loan Full Amount', true);
INSERT INTO loan_service_charge_basis (id, version, code, description, status) VALUES (2, 1, '020', 'Loan Principal Balance', true);
INSERT INTO loan_service_charge_basis (id, version, code, description, status) VALUES (3, 1, '030', 'Loan Principal Due ', true);
INSERT INTO loan_service_charge_basis (id, version, code, description, status) VALUES (4, 1, '040', 'Loan Principal + Interest Due', true);
INSERT INTO loan_service_charge_basis (id, version, code, description, status) VALUES (5, 1, '050', 'Loan Interest Due', true);


--
-- TOC entry 2943 (class 0 OID 261589)
-- Dependencies: 215
-- Data for Name: loan_service_charge_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_service_charge_type (id, version, code, description, status) VALUES (1, 1, '010', 'Fixed Amount', true);
INSERT INTO loan_service_charge_type (id, version, code, description, status) VALUES (2, 1, '020', 'Rate', true);
INSERT INTO loan_service_charge_type (id, version, code, description, status) VALUES (3, 1, '030', 'Special Calculation (GRT)', true);
INSERT INTO loan_service_charge_type (id, version, code, description, status) VALUES (4, 1, '040', 'Manual', true);


--
-- TOC entry 2968 (class 0 OID 296062)
-- Dependencies: 240
-- Data for Name: loan_special_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO loan_special_type (id, version, code, description, status) VALUES (1, 1, '010', 'Litigation', true);
INSERT INTO loan_special_type (id, version, code, description, status) VALUES (2, 1, '020', 'Write-Off', true);
INSERT INTO loan_special_type (id, version, code, description, status) VALUES (3, 1, '030', 'ROPA', true);


--
-- TOC entry 2965 (class 0 OID 273974)
-- Dependencies: 237
-- Data for Name: lov; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (1, 1, 'CT', 'Customer title', '001', 'Mr.', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (2, 1, 'CT', 'Customer title', '002', 'Ms.', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (3, 1, 'CT', 'Customer title', '003', 'Engr.', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (4, 1, 'CT', 'Customer title', '004', 'Atty.', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (5, 1, 'CT', 'Customer title', '005', 'Msgr.', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (6, 1, 'CON', 'Contact type', '001', 'Landline', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (7, 1, 'CON', 'Contact type', '002', 'Cellphone/Mobile', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (8, 1, 'CON', 'Contact type', '003', 'Email', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (9, 1, 'CON', 'Contact type', '004', 'Twitter', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (10, 1, 'CON', 'Contact type', '005', 'Instagram', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (11, 1, 'CON', 'Contact type', '006', 'Facebook', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (12, 1, 'EIT', 'Industry Classification', '001', 'Agriculture', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (13, 1, 'EIT', 'Industry Classification', '002', 'Manufacturing', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (14, 1, 'EIT', 'Industry Classification', '003', 'Finance', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (15, 1, 'EIT', 'Industry Classification', '004', 'Hospitality', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (16, 1, 'EIT', 'Industry Classification', '005', 'Services', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (17, 1, 'EIT', 'Industry Classification', '006', 'Food and Beverage', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (18, 1, 'CET', 'Employment Type', '001', 'N/A', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (19, 1, 'CET', 'Employment Type', '002', 'Probationary', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (20, 1, 'CET', 'Employment Type', '003', 'Contractual', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (21, 1, 'CET', 'Employment Type', '004', 'Permanent', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (22, 1, 'CET', 'Employment Type', '005', 'Owner', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (23, 1, 'CS', 'Civil Status', 'S', 'Single', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (24, 1, 'CS', 'Civil Status', 'M', 'Married', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (25, 1, 'CS', 'Civil Status', 'W', 'Widowed', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (26, 1, 'CS', 'Civil Status', 'D', 'Divorced', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (27, 1, 'CS', 'Civil Status', '0', 'Not Applicable (non-person)', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (28, 1, 'RTYP', 'REM Collateral Type', '001', 'House and Lot', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (29, 1, 'RTYP', 'REM Collateral Type', '002', 'Agricultural irrigated', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (30, 1, 'RTYP', 'REM Collateral Type', '003', 'Agricultural not irrigated', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (31, 1, 'RTYP', 'REM Collateral Type', '004', 'Raw land', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (32, 1, 'CVT', 'Collateral - Vehicle Type', '001', 'Car', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (33, 1, 'CVT', 'Collateral - Vehicle Type', '002', 'Van', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (34, 1, 'CVT', 'Collateral - Vehicle Type', '003', 'SUV', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (35, 1, 'CVT', 'Collateral - Vehicle Type', '004', 'Public Utility Vehicle', true);
	INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (36, 1, 'CRT', 'Customer Relationship Type', '001', 'Parent', true);
	INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (37, 1, 'CRT', 'Customer Relationship Type', '002', 'Child', true);
	INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (38, 1, 'CRT', 'Customer Relationship Type', '003', 'Sibling', true);
	INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (39, 1, 'CRT', 'Customer Relationship Type', '004', 'Grandparent', true);
	INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (40, 1, 'CRT', 'Customer Relationship Type', '005', 'Grandchild', true);
	INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (41, 1, 'CRT', 'Customer Relationship Type', '006', 'Others', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (42, 1, 'CEDT', 'Customer Education Type', '001', 'Elementary', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (43, 1, 'CEDT', 'Customer Education Type', '002', 'High School', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (44, 1, 'CEDT', 'Customer Education Type', '003', 'College', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (45, 1, 'CEDT', 'Customer Education Type', '004', 'Vocational', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (46, 1, 'CEDT', 'Customer Education Type', '005', 'Post-Graduate', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (47, 1, 'CIDT', 'Presented ID Type', '001', 'SSS', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (48, 1, 'CIDT', 'Presented ID Type', '002', 'GSIS', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (49, 1, 'CIDT', 'Presented ID Type', '003', 'Passport', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (50, 1, 'CIDT', 'Presented ID Type', '004', 'Drivers License', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (51, 1, 'CIDT', 'Presented ID Type', '005', 'Company ID', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (52, 1, 'CIDT', 'Presented ID Type', '006', 'School ID', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (53, 1, 'CIDT', 'Presented ID Type', '007', 'Postal ID', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (54, 1, 'CTRY', 'Country', '001', 'Philippines', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (55, 1, 'CTRY', 'Country', '002', 'Singapore', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (56, 1, 'RGN', 'Region', '001', 'Region I', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (57, 1, 'RGN', 'Region', '002', 'Region II', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (58, 1, 'PROV', 'Province', '001', 'NCR', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (59, 1, 'PROV', 'Province', '002', 'Batangas', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (60, 1, 'LANG', 'Language', '001', 'English', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (61, 1, 'LANG', 'Language', '002', 'Filipino', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (62, 1, 'SPEC', 'Specialization', '001', 'SP1', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (63, 1, 'SPEC', 'Specialization', '002', 'SP2', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (64, 1, 'CIFEXT', 'CIF Extended Information', '001', 'CIFCODE1', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (65, 1, 'CIFEXT', 'CIF Extended Information', '002', 'CIFCODE2', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (66, 1, 'CIFEXT', 'CIF Extended Information', '003', 'CIFCODE3', true);
INSERT INTO lov (id, version, group_code, group_description, item_code, item_value, status) VALUES (67, 1, 'CIFEXT', 'CIF Extended Information', '004', 'CIFCODE4', true);


--
-- TOC entry 2944 (class 0 OID 261594)
-- Dependencies: 216
-- Data for Name: memo_txn_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO memo_txn_type (id, version, code, description, status) VALUES (1, 1, '010', 'General', true);
INSERT INTO memo_txn_type (id, version, code, description, status) VALUES (2, 1, '020', 'Bills Payment', true);
INSERT INTO memo_txn_type (id, version, code, description, status) VALUES (3, 1, '030', 'Remittance', true);


--
-- TOC entry 2945 (class 0 OID 261617)
-- Dependencies: 217
-- Data for Name: other_acct_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO other_acct_type (id, version, code, description, status) VALUES (1, 1, '010', 'Savings Account', true);
INSERT INTO other_acct_type (id, version, code, description, status) VALUES (2, 1, '020', 'Current Account', true);
INSERT INTO other_acct_type (id, version, code, description, status) VALUES (3, 1, '030', 'Time Deposit Account', true);
INSERT INTO other_acct_type (id, version, code, description, status) VALUES (4, 1, '040', 'Credit Card', true);
INSERT INTO other_acct_type (id, version, code, description, status) VALUES (5, 1, '050', 'Debit Card', true);
INSERT INTO other_acct_type (id, version, code, description, status) VALUES (6, 1, '060', 'Loan Account', true);


--
-- TOC entry 2946 (class 0 OID 261622)
-- Dependencies: 218
-- Data for Name: ownership_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO ownership_type (id, version, code, description, status) VALUES (1, 1, '010', 'Single', true);
INSERT INTO ownership_type (id, version, code, description, status) VALUES (2, 1, '020', 'And', true);
INSERT INTO ownership_type (id, version, code, description, status) VALUES (3, 1, '030', 'Or', true);
INSERT INTO ownership_type (id, version, code, description, status) VALUES (4, 1, '040', 'And/Or', true);
INSERT INTO ownership_type (id, version, code, description, status) VALUES (5, 1, '050', 'By', true);
INSERT INTO ownership_type (id, version, code, description, status) VALUES (6, 1, '060', 'In Trust For', true);
INSERT INTO ownership_type (id, version, code, description, status) VALUES (7, 1, '070', 'Others', true);


--
-- TOC entry 2947 (class 0 OID 261627)
-- Dependencies: 219
-- Data for Name: passbook_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO passbook_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO passbook_status (id, version, code, description, status) VALUES (2, 1, '100', 'Issued', true);
INSERT INTO passbook_status (id, version, code, description, status) VALUES (3, 1, '990', 'Cancelled', true);
INSERT INTO passbook_status (id, version, code, description, status) VALUES (4, 1, '999', 'Removed', true);


--
-- TOC entry 2948 (class 0 OID 261632)
-- Dependencies: 220
-- Data for Name: password_complexity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO password_complexity (id, version, code, description, status) VALUES (1, 1, '000', 'None', true);
INSERT INTO password_complexity (id, version, code, description, status) VALUES (2, 1, '010', 'Alphanumeric', true);
INSERT INTO password_complexity (id, version, code, description, status) VALUES (3, 1, '020', 'Alphanumeric Upper Lower Case', true);
INSERT INTO password_complexity (id, version, code, description, status) VALUES (4, 1, '030', 'Alphanumeric Upper Lower Case Special Character', true);


--
-- TOC entry 2949 (class 0 OID 261637)
-- Dependencies: 221
-- Data for Name: pdc_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO pdc_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (2, 1, '010', 'Approaching', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (3, 1, '100', 'Used - Good', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (4, 1, '210', 'Used - Returned DAIF', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (5, 1, '220', 'Used - Returned DAUD', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (6, 1, '230', 'Used - Returned Closed', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (7, 1, '240', 'Used - Returned SPO', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (8, 1, '990', 'Removed', true);
INSERT INTO pdc_status (id, version, code, description, status) VALUES (9, 1, '999', 'Cancelled', true);


--
-- TOC entry 2950 (class 0 OID 261678)
-- Dependencies: 222
-- Data for Name: product_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO product_type (id, version, code, description, status) VALUES (1, 1, '010', 'Savings Account', true);
INSERT INTO product_type (id, version, code, description, status) VALUES (2, 1, '020', 'Current Account', true);
INSERT INTO product_type (id, version, code, description, status) VALUES (3, 1, '030', 'Time Deposit', true);
INSERT INTO product_type (id, version, code, description, status) VALUES (4, 1, '040', 'Bills Payable', true);
INSERT INTO product_type (id, version, code, description, status) VALUES (5, 1, '050', 'Other Payables', true);
INSERT INTO product_type (id, version, code, description, status) VALUES (6, 1, '060', 'Loans', true);
INSERT INTO product_type (id, version, code, description, status) VALUES (7, 1, '070', 'Sales Contract Receivable', true);
INSERT INTO product_type (id, version, code, description, status) VALUES (8, 1, '080', 'Other Receivable', true);


--
-- TOC entry 2951 (class 0 OID 261701)
-- Dependencies: 223
-- Data for Name: report_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2952 (class 0 OID 261706)
-- Dependencies: 224
-- Data for Name: report_type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2953 (class 0 OID 261721)
-- Dependencies: 225
-- Data for Name: rollover_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rollover_status (id, version, code, description, status) VALUES (1, 1, '000', 'Approaching', true);
INSERT INTO rollover_status (id, version, code, description, status) VALUES (2, 1, '900', 'Completed', true);
INSERT INTO rollover_status (id, version, code, description, status) VALUES (3, 1, '999', 'Cancelled', true);


--
-- TOC entry 2954 (class 0 OID 261726)
-- Dependencies: 226
-- Data for Name: rollover_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO rollover_type (id, version, code, description, status) VALUES (1, 1, '000', 'None', true);
INSERT INTO rollover_type (id, version, code, description, status) VALUES (2, 1, '010', 'Principal', true);
INSERT INTO rollover_type (id, version, code, description, status) VALUES (3, 1, '020', 'Principal + Interest', true);


--
-- TOC entry 2955 (class 0 OID 261736)
-- Dependencies: 227
-- Data for Name: standing_order_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO standing_order_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO standing_order_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO standing_order_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO standing_order_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2956 (class 0 OID 261741)
-- Dependencies: 228
-- Data for Name: stop_payment_order_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO stop_payment_order_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO stop_payment_order_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO stop_payment_order_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO stop_payment_order_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2966 (class 0 OID 273979)
-- Dependencies: 238
-- Data for Name: sweep_rule; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sweep_rule (id, version, code, description, status) VALUES (1, 1, '010', 'Full Available Balance', true);
INSERT INTO sweep_rule (id, version, code, description, status) VALUES (2, 1, '020', 'Full Closing Balance', true);
INSERT INTO sweep_rule (id, version, code, description, status) VALUES (3, 1, '030', 'Fixed amount', true);
INSERT INTO sweep_rule (id, version, code, description, status) VALUES (4, 1, '040', 'Percentage', true);


--
-- TOC entry 2957 (class 0 OID 261746)
-- Dependencies: 229
-- Data for Name: sweep_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO sweep_status (id, version, code, description, status) VALUES (1, 1, '000', 'Pending', true);
INSERT INTO sweep_status (id, version, code, description, status) VALUES (2, 1, '010', 'Active', true);
INSERT INTO sweep_status (id, version, code, description, status) VALUES (3, 1, '990', 'Removed', true);
INSERT INTO sweep_status (id, version, code, description, status) VALUES (4, 1, '999', 'Cancelled', true);


--
-- TOC entry 2958 (class 0 OID 261756)
-- Dependencies: 230
-- Data for Name: system_module; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO system_module (id, version, code, description, status) VALUES (1, 1, '010', 'Customer Information', true);
INSERT INTO system_module (id, version, code, description, status) VALUES (2, 1, '020', 'Admin and Config', true);
INSERT INTO system_module (id, version, code, description, status) VALUES (3, 1, '030', 'Deposit Accounts Management', true);
INSERT INTO system_module (id, version, code, description, status) VALUES (4, 1, '040', 'Loan Accounts Management', true);
INSERT INTO system_module (id, version, code, description, status) VALUES (5, 1, '050', 'Teller Transactions Module', true);
INSERT INTO system_module (id, version, code, description, status) VALUES (6, 1, '060', 'General Ledger', true);
INSERT INTO system_module (id, version, code, description, status) VALUES (7, 1, '070', 'Management Information System', true);


--
-- TOC entry 2959 (class 0 OID 261761)
-- Dependencies: 231
-- Data for Name: tax_fee_charge; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tax_fee_charge (id, version, code, description, status) VALUES (1, 1, '100', 'Tax', true);
INSERT INTO tax_fee_charge (id, version, code, description, status) VALUES (2, 1, '200', 'Fee', true);
INSERT INTO tax_fee_charge (id, version, code, description, status) VALUES (3, 1, '300', 'Charge', true);


--
-- TOC entry 2967 (class 0 OID 296053)
-- Dependencies: 239
-- Data for Name: tfc_special_calculation_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tfc_special_calculation_type (id, version, code, description, status) VALUES (1, 1, '010', 'Documetary Stamp Tax', true);
INSERT INTO tfc_special_calculation_type (id, version, code, description, status) VALUES (2, 1, '020', 'Long Term Tax', true);
INSERT INTO tfc_special_calculation_type (id, version, code, description, status) VALUES (3, 1, '030', 'DAIF Charge (PCHC)', true);
INSERT INTO tfc_special_calculation_type (id, version, code, description, status) VALUES (4, 1, '040', 'DAUD Charge (PCHC)', true);


--
-- TOC entry 2960 (class 0 OID 261781)
-- Dependencies: 232
-- Data for Name: txn_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO txn_type (id, version, code, description, status) VALUES (1, 1, '10', 'Cash from vault', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (2, 1, '20', 'Teller Cash Transfer', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (3, 1, '30', 'Cash Deposit', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (4, 1, '40', 'Check Deposit', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (5, 1, '50', 'Cash Withdrawal', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (6, 1, '60', 'Check Encashment', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (7, 1, '70', 'Memo Debit ', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (8, 1, '80', 'Fund Transfer', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (9, 1, '90', 'Memo Credit', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (10, 1, '100', 'Loan Proceeds Disbursement', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (11, 1, '110', 'Loan Cash Payment', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (12, 1, '120', 'Loan Check Payment', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (13, 1, '130', 'Loan Cash - Specified Payment', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (14, 1, '140', 'Loan Check - Specified Payment', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (15, 1, '150', 'Fixed Deposit Interest Withdrawal', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (16, 1, '160', 'Fixed Deposit Pre-termination', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (17, 1, '170', 'Other Cash Receipt', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (18, 1, '180', 'Other Check Receipt ', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (19, 1, '190', 'Other Cash Payment', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (20, 1, '200', 'Teller Checks to COCI Transaction', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (21, 1, '210', 'Teller Cash to Vault Transaction', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (22, 1, '220', 'Foreign Currency Exchange Transaction', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (23, 1, '710', 'Batch Debit', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (24, 1, '720', 'Batch Credit', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (25, 1, '730', 'Batch Transfer', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (26, 1, '800', 'Account Re-classification', true);
INSERT INTO txn_type (id, version, code, description, status) VALUES (27, 1, '900', 'System', true);


-- Completed on 2014-10-25 13:56:38 PHT

--
-- PostgreSQL database dump complete
--

