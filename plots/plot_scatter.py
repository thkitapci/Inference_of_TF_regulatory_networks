
#def multipage(filename, figs=None, dpi=200):
#    pp = PdfPages(filename)
#    if figs is None:
#        figs = [plt.figure(n) for n in plt.get_fignums()]
#    for fig in figs:
#        fig.savefig(pp, format='pdf')
#        pp.close()



#Author T. Hamdi Kitapci
# Our numerical workhorses
import numpy as np
import scipy.integrate
import sys
# Import pyplot for plotting
import matplotlib.pyplot as plt

# Seaborn, useful for graphics
#import seaborn as sns

# Import Bokeh modules for interactive plotting
import bokeh.io
import bokeh.mpl
import bokeh.plotting



###########Set plotly offline mode

# In[21]:

from sklearn import linear_model
import pandas as pd
import matplotlib.patches as mpatches
import glob
import os
from matplotlib.backends.backend_pdf import PdfPages

all_files=[]

#print "neden_yazmiyor"


if len(sys.argv) !=2:
    print "Missing argument usage *.py path_to_dir_with_txts"
    sys.exit()
path_to_input=sys.argv[1]

#txt format is "Gene_Name","Number_of_binding_site","Average_strength_of_binding","Expression_covariation"

#for f in glob.glob('data_for_plots_num_of_binding/*.txt'):
#for f in glob.glob('data_for_plots_str_of_binding/*.txt'):
#for f in glob.glob('data_for_plots/*.txt'):
for f in glob.glob(path_to_input+'/*.txt'):
    all_files.append(str(f))

print (all_files)
#print "ahanda"

all_files.sort(key=str.lower) #sort file names lexicographically

pdf_str_of_binding=PdfPages(path_to_input+"/Exp_cov_vs_str_of_binding.pdf")
pdf_num_of_binding=PdfPages(path_to_input+"/Exp_cov_vs_num_of_binding.pdf")



for i in range(0,len(all_files)):
    filename=all_files[i]
    df=pd.read_table(filename,names=["gene_names","num_of_binding","str_of_binding","exp_covariation"],header=1,sep=",")

    ########################################
    ########################################
    #plotly BEGIN##################################33    
    #data = [go.Histogram2d(x=df["exp_covariation"],y=df["str_of_binding"])]
    #iplot(data)
    ##########################################################################
    #END
    ##########################################################################
    #plt.figure(frameon=False)
    #f,axarr=plt.subplots(1,2,sharex=True, sharey=True)
    
        

    #Plot exp_covariation vs str_of_binding
    fig=plt.figure()
    plt.hist2d(df["exp_covariation"],df["str_of_binding"])
    plt.colorbar()
    
    #A=np.histogram2d(df["exp_covariation"],df["str_of_binding"])
    #plt.show(A)
    # Create linear regression object

    regr = linear_model.LinearRegression()
    
    TF_name=os.path.basename(filename).split(".")[0]
    plt.title(TF_name)
    plt.scatter(df["exp_covariation"],df["str_of_binding"],color='black')
    pos=df[df["exp_covariation"]>=0]
    x=np.reshape(pos["exp_covariation"],(-1,1))           #NEED TO DO THIS reshape stuff for some reason!
    y=np.reshape(pos["str_of_binding"],(-1,1))
    regr.fit(x,y)
    r_square_pos=regr.score(x,y)
    
    plt.plot(x, regr.predict(x), color='blue',linewidth=3)
    
    blue_patch = mpatches.Patch(color='blue', label="$r^2$=%.4f"%(r_square_pos))
    
    neg=df[df["exp_covariation"]<=0]
    x=np.reshape(neg["exp_covariation"],(-1,1))
    y=np.reshape(neg["str_of_binding"],(-1,1))
    regr.fit(x,y)
    r_square_neg=regr.score(x,y)
    plt.plot(x, regr.predict(x), color='red',linewidth=3)
        
    red_patch = mpatches.Patch(color='red', label="$r^2$=%.4f"%(r_square_neg))
    
    plt.legend(handles=[red_patch,blue_patch],bbox_to_anchor=(1.00, 1.15))
    #plt.legend(bbox_to_anchor=(1, 1),bbox_transform=plt.gcf().transFigure)
    
    my_font = {'family': 'Times',
        'weight': 'normal',
        'size': 16,
        }
    
    plt.figtext(0.1,0.95,chr(ord("A")+i),fontdict=my_font)
    plt.xlabel("Expression covariation",fontsize=14)
    #plt.ylabel("Number of binding sites",fontsize=14)
    plt.ylabel("Average strength of TF binding sites",fontsize=14)
    #plt.show()
    pdf_str_of_binding.savefig(fig)
    plt.close(fig)

    #Plot exp_covariation vs num_binding
    

    fig=plt.figure()
    plt.hist2d(df["exp_covariation"],df["num_of_binding"])
    plt.colorbar()
    
    

    regr = linear_model.LinearRegression()
    
    TF_name=os.path.basename(filename).split(".")[0]
    plt.title(TF_name)
    plt.scatter(df["exp_covariation"],df["num_of_binding"],color='black')
    pos=df[df["exp_covariation"]>=0]
    x=np.reshape(pos["exp_covariation"],(-1,1))           #NEED TO DO THIS reshape stuff for some reason!
    y=np.reshape(pos["num_of_binding"],(-1,1))
    regr.fit(x,y)
    r_square_pos=regr.score(x,y)
    
    plt.plot(x, regr.predict(x), color='blue',linewidth=3)
    
    blue_patch = mpatches.Patch(color='blue', label="$r^2$=%.4f"%(r_square_pos))
    
    neg=df[df["exp_covariation"]<=0]
    x=np.reshape(neg["exp_covariation"],(-1,1))
    y=np.reshape(neg["num_of_binding"],(-1,1))
    regr.fit(x,y)
    r_square_neg=regr.score(x,y)
    plt.plot(x, regr.predict(x), color='red',linewidth=3)
        
    red_patch = mpatches.Patch(color='red', label="$r^2$=%.4f"%(r_square_neg))
    
    plt.legend(handles=[red_patch,blue_patch],bbox_to_anchor=(1.00, 1.15))
    #plt.legend(bbox_to_anchor=(1, 1),bbox_transform=plt.gcf().transFigure)
    
    plt.figtext(0.1,0.95,chr(ord("A")+i),fontdict=my_font)
    
    
    plt.xlabel("Expression covariation",fontsize=14)
    plt.ylabel("Number of binding sites",fontsize=14)
    
    #plt.show()
    pdf_num_of_binding.savefig(fig)
    plt.close(fig)

pdf_num_of_binding.close()
pdf_str_of_binding.close()
    
    
    #plt.savefig("%s.png"%(filename.split(".")[0]))
    #plt.savefig("%s.jpg"%(filename.split(".")[0]))
    


# In[ ]:



