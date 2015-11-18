@echo off
setlocal EnableDelayedExpansion
set _dt=%date:~10,4%_%date:~4,2%_%date:~7,2%
set bk_dir="L:\File_list_backup"
set ls_dir=C:\msls\ls.exe
set drv_ltrs=drive_letters.txt
echo Starting output...
FOR /F %%i IN (%drv_ltrs%) DO (
set cur_ltr=%%i
echo Running ls on %%i:\...
mkdir !bk_dir!\!cur_ltr!\%_dt%-!cur_ltr!_ls_tree
!ls_dir! -lhaR --time-style=long-iso !cur_ltr!:\* > !bk_dir!\!cur_ltr!\%_dt%-!cur_ltr!_ls_tree\%_dt%-!cur_ltr!_ls.txt 2>!bk_dir!\!cur_ltr!\%_dt%-!cur_ltr!_ls_tree\%_dt%-!cur_ltr!_ls_errors.txt
echo Running tree on %%i:\...
tree /F /A !cur_ltr!:\ > !bk_dir!\!cur_ltr!\%_dt%-!cur_ltr!_ls_tree\%_dt%-!cur_ltr!_tree.txt 2>!bk_dir!\!cur_ltr!\%_dt%-!cur_ltr!_ls_tree\%_dt%-!cur_ltr!_tree_errors.txt
echo **********************************
echo Compressing Data
echo **********************************
cd !bk_dir!\!cur_ltr!\
"C:\Program Files\7-Zip\7z.exe" a %_dt%-!cur_ltr!_ls_tree.zip %_dt%-!cur_ltr!_ls_tree\%_dt%*.txt
)
echo **********************************
echo Completed File Listing
echo **********************************
pause
