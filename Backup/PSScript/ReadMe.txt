- Replace Username & Password

- Replace URL and insert "XLSX&" (if you need excel file) after https://atosglobal.service-now.com/sys_report_template.do?

?XLSX&... => .xlsx
?PDF&... => .pdf
?CSV&... => .csv

e.g.
https://atosglobal.service-now.com/sys_report_template.do?XLSX&jvar_report_id=28ce8d5487150690e8eb64a73cbb350f&jvar_selected_tab=myReports&jvar_list_order_by=&jvar_list_sort_direction=&sysparm_reportquery=&jvar_search_created_by=&jvar_search_table=&jvar_search_report_sys_id=&jvar_report_home_query=&sysparm_use_polaris=true

- Replace reportname "report" (optional)

- Replace the download path also at the end of script