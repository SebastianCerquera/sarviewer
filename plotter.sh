#!/bin/bash
#
# Script        :plotter.sh
# Author        :Julio Sanz
# Website       :www.elarraydejota.com
# Email         :juliojosesb@gmail.com
# Description   :Script to generate graphs in the folder graphs/ of this repository
# Dependencies  :sar,gnuplot
# Usage         :1)Give executable permissions to script -> chmod +x plotter.sh
#                2)Execute script -> ./plotter.sh
# License       :GPLv3
#

# Read sarviewer.properties file
. sarviewer.properties

if [ $# -ne 0 ];then
	echo "This script doesn't accept parameters"
elif [ "$graph_generator" == "gnuplot" ];then
	cd plotters/gnuplot
	gnuplot loadaverage.gplot
	gnuplot tasks.gplot
	gnuplot cpu.gplot
	gnuplot ram.gplot
	gnuplot swap.gplot

        for i in $(ls ../../data | perl -ne 'if(/iotransfer\.dat\.+/){@A = split(".dat.", $_); print $A[$#A]}'); do
	    cp iotransfer.gplot iotransfer.gplot.$i
            perl -pi -e 's/..\/..\/graphs\/iotransfer\.png/..\/..\/graphs\/iotransfer\.'"$i"'\.png/g' iotransfer.gplot.$i
            perl -pi -e 's/..\/..\/data\/iotransfer\.dat/..\/..\/data\/iotransfer\.dat.'"$i"'/g' iotransfer.gplot.$i
            gnuplot iotransfer.gplot.$i

            cp ioutil.gplot ioutil.gplot.$i
            perl -pi -e 's/..\/..\/graphs\/ioutil\.png/..\/..\/graphs\/ioutil\.'"$i"'\.png/g' ioutil.gplot.$i
            perl -pi -e 's/..\/..\/data\/iotransfer\.dat/..\/..\/data\/iotransfer\.dat.'"$i"'/g' ioutil.gplot.$i
            gnuplot ioutil.gplot.$i
        done

        gnuplot iostat.gplot
        
	gnuplot proc.gplot
	gnuplot contextsw.gplot
	gnuplot netinterface.gplot
	gnuplot sockets.gplot
elif [ "$graph_generator" == "matplotlib" ];then
#        cd plotters/matplotlib
#        python loadaverage.py
#        python tasks.py
#        python cpu.py
#        python ram.py
#        python swap.py
# 
#        # it is still missing to plot each io device.
#        python iotransfer.py
#        python proc.py
#        python contextsw.py
#        python netinterface.py
#        python sockets.py
        echo "This is no longer supported"
else
	echo "Variable graph_generator must be \"gnuplot\" or \"matplotlib\", please check sarviewer.properties"
fi
