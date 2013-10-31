
#!/bin/sh
#################################################################################
#                                                                               #
#    This program is free software: you can redistribute it and/or modify       #
#    it under the terms of the GNU General Public License as published by       #
#    the Free Software Foundation, either version 3 of the License, or          #
#    (at your option) any later version.                                        #
#                                                                               #
#    This program is distributed in the hope that it will be useful,            #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of             #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              #
#    GNU General Public License for more details.                               #
#                                                                               #
#    You should have received a copy of the GNU General Public License          #
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.      #
#                                                                               #
#################################################################################
#
# By Thomas Bourcey <sckyzo@gmail.com>
#
# Script for exporting SVGs to PNGs with Inkscape.
# Optimize png with optipng
# sort png by size
# Debug mode :)
# set -x
 
 
## CHANGE ONLY THIS VARIABLES ##
################################
 
ICON_FOLDER="path_to_the_destination"
SIZE="16 22 24 32 48 64 96 256"
 
 
## DO NOT TOUCH AFTER ##
########################
 
# for each file ending with .svg
for file in *.svg
do
        # strip the .svg part and save output as $filename
        filename=`echo "${file}" | sed s/.svg//`
 
        # Generate PNG
        for WIDTH in $SIZE; do
                # export current file to .png
                /usr/bin/inkscape -z -f "${file}" -w $WIDTH -e "$filename.png"
 
                # optipng
                optipng -o9 *.png
 
                # move files
                for PNG in *.png*
                do
                        if [ -f $PNG ]; then
                        format=`identify -format '%w' $PNG`
                                # Create directory
                                if [ ! -f ${ICON_FOLDER}/${format}x${format}/apps ]; then
                                        mkdir -p ${ICON_FOLDER}/${format}x${format}/apps
                                fi
                                # Move files
                                mv -i $PNG ${ICON_FOLDER}/${format}x${format}/apps/${PNG}
                        else
                                # If no icons
                                echo "There are no PNG files"
                        fi
                done
        done
done
