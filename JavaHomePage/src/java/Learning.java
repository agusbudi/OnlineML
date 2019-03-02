
import java.io.File;
import java.io.FileWriter;
import java.util.Arrays;
import libsvm.LibSVM;
import weka.classifiers.Classifier;
import weka.classifiers.bayes.AveragedNDependenceEstimators.A1DE;
import weka.classifiers.bayes.AveragedNDependenceEstimators.A2DE;
import weka.classifiers.bayes.BayesNet;
import weka.classifiers.bayes.HNB;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.bayes.NaiveBayesUpdateable;
import weka.classifiers.functions.KernelLogisticRegression;
import weka.classifiers.functions.LinearRegression;
import weka.classifiers.functions.Logistic;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.classifiers.functions.SMO;
import weka.classifiers.functions.SimpleLogistic;
import weka.classifiers.lazy.IBk;
import weka.classifiers.lazy.KStar;
import weka.classifiers.lazy.LBR;
import weka.classifiers.lazy.LWL;
import weka.classifiers.meta.FilteredClassifier;
import weka.classifiers.rules.DTNB;
import weka.classifiers.rules.DecisionTable;
import weka.classifiers.rules.JRip;
import weka.classifiers.rules.LAC;
import weka.classifiers.rules.PART;
import weka.classifiers.rules.ZeroR;
import weka.classifiers.trees.BFTree;
import weka.classifiers.trees.DecisionStump;
import weka.classifiers.trees.HoeffdingTree;
import weka.classifiers.trees.J48;
import weka.classifiers.trees.LMT;
import weka.classifiers.trees.REPTree;
import weka.classifiers.trees.RandomForest;
import weka.classifiers.trees.SimpleCart;
import weka.core.Instance;
import weka.core.Instances;

/**
 *
 * @author raharjo
 */
public class Learning {
    
    private String report;
    private String train;
    private String test;
    private int nClassifier;
    private String options;
    private String ConfusionMatrix;
    
    public Learning(String train, String test) throws Exception {
        this.train = train;
        this.test = test;
        
        this.nClassifier=29;
        String report="";
        this.options = "";
        this.ConfusionMatrix = "";
    }
    
    public void TrainTest(boolean [] algo, String [] options) throws Exception {
        int limit =2;
         
        Instances datatrain = ReadFile(train);
        Instances datatest = ReadFile(test);
        int numDataTrain = datatrain.numInstances();
        int numDataTest = datatest.numInstances();
        double interval = 0.1;
        String separator =",";
        
        // base classifier
        int classifierNum = 50;
        Classifier learn[] = new Classifier[classifierNum];
        int x = 0;
        //lazy
        if(algo[0]==true){
            IBk cls = new IBk();
            if(!options[0].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[0]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[0]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[1]==true){
            KStar cls = new KStar();
            if(!options[1].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[1]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[1]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }       
        if(algo[2]==true){
            LWL cls = new LWL();
            if(!options[2].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[2]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[2]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }       
        if(algo[3]==true){
            LBR cls = new LBR();
            if(!options[3].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[3]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[3]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }       
        
        
        //Tree
        if(algo[4]==true){
            J48 cls = new J48();
            if(!options[4].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[4]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[4]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[5]==true){
             DecisionStump cls = new DecisionStump();
            if(!options[5].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[5]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[5]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[6]==true){
            HoeffdingTree cls = new HoeffdingTree();
            if(!options[6].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[6]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[6]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[7]==true){
            LMT cls = new LMT();
            if(!options[7].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[7]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[7]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[8]==true){
            REPTree cls = new REPTree();
            if(!options[6].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[6]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[6]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[9]==true){
            SimpleCart cls = new SimpleCart();
            if(!options[9].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[9]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[9]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }  
        if(algo[10]==true){
            BFTree cls = new BFTree();
            if(!options[10].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[10]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[10]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }      
        if(algo[11]==true){
            RandomForest cls = new RandomForest();
            if(!options[11].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[11]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[11]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }  
        
        
        //bayes
        if(algo[12]==true){
            BayesNet cls = new BayesNet();
            if(!options[12].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[12]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[12]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }                     
        if(algo[13]==true){
            NaiveBayesUpdateable cls = new NaiveBayesUpdateable();
            if(!options[13].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[13]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[13]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }  
        if(algo[14]==true){
            A1DE cls = new A1DE();
            if(!options[14].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[14]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[14]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }     
        if(algo[15]==true){
            A2DE cls = new A2DE();
            if(!options[15].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[15]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[15]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }    
        if(algo[16]==true){
            HNB cls = new HNB();
            if(!options[16].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[16]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[16]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }  
        if(algo[17]==true){
            NaiveBayes cls = new NaiveBayes();
            if(!options[17].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[17]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[17]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        
        
        //Rules
        if(algo[18]==true){
            LAC cls = new LAC();
            if(!options[18].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[18]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[18]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }   
        if(algo[19]==true){
            DTNB cls = new DTNB();
            if(!options[19].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[19]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[19]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }                      
        if(algo[20]==true){
            PART cls = new PART();
            if(!options[20].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[20]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[20]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }    
        if(algo[21]==true){
            ZeroR cls = new ZeroR();
            if(!options[21].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[21]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[21]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }   
        if(algo[22]==true){
            JRip cls = new JRip();
            if(!options[22].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[22]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[22]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[23]==true){
            DecisionTable cls = new DecisionTable();
            if(!options[23].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[23]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[23]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }  
        
//        learn[x++] = new Ridor();
//        learn[x++] = new OneR(); *
//        learn[x++] = new ConjunctiveRule();    *    



        //function           
        if(algo[24]==true){
            MultilayerPerceptron cls = new MultilayerPerceptron();
            if(!options[24].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[24]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[24]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }       
        if(algo[25]==true){
            SimpleLogistic cls = new SimpleLogistic();
            if(!options[25].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[25]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[25]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }       
        if(algo[26]==true){
            SMO cls = new SMO();
            cls.setBuildCalibrationModels(true);
            if(!options[26].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[26]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[26]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;  
        }
        if(algo[27]==true){
            Logistic cls = new Logistic();
            if(!options[27].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[27]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[27]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }          
        if(algo[28]==true){
            KernelLogisticRegression cls = new KernelLogisticRegression();
            if(!options[28].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[28]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[28]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        if(algo[29]==true){
            LinearRegression cls = new LinearRegression();
            if(!options[29].equals("")){
                try{
                    String[] option = weka.core.Utils.splitOptions(options[29]);
                    cls.setOptions(option);
                }catch(Exception ex){
                    options[29]= "Options error: " + ex.toString();
                }
            }
            learn[x++] = cls;                 
        }
        
        
        //LibSVM svm = new LibSVM();
        //    svm.setProbabilityEstimates(true);        
        //learn[x++] = (Classifier) svm;            
//        learn[x++] = new SGD();             
//        learn[x++] = new VotedPerceptron(); *   
        
        //misc
//        learn[x++] = new HyperPipes();  *
//        for(int i=x;i<classifierNum;i++){
//            learn[i] = new spammer();
//        }
//        for(int i=x;i<classifierNum;i++)
//            learn[i]=new spammer();
        classifierNum=x;
//calculate training time        
        long startTime = System.currentTimeMillis();
//set the classifier
        FilteredClassifier[] fc = new FilteredClassifier[classifierNum];
        for(int p=0;p<classifierNum;p++){          
            fc[p] = new FilteredClassifier();
            fc[p].setClassifier(learn[p]);
        }      

// train
        for(int p=0;p<classifierNum;p++){     
            fc[p].buildClassifier(datatrain);
//            System.out.println("\t- classifiers " + (p+1) + " : " + learn[p].toString().split("\n")[0] + " is done");
        }          

        long endTime   = System.currentTimeMillis();
        long totalTime = endTime - startTime;
        
        report = report + "Training time: " + totalTime + " ms<br/>";  
        
        startTime = System.currentTimeMillis();
        
//build the template
        int numBin = (int)Math.ceil(1/interval);
        int [][] Reliability = new int[numBin][classifierNum]; //row: interval, column: each classifier
        int [][] TruthReliability = new int[numBin][classifierNum]; //row: interval, column: each classifier
        for(int aa=0;aa<numBin;aa++)
            Arrays.fill(Reliability[aa], 0);
        for(int aa=0;aa<numBin;aa++)
            Arrays.fill(TruthReliability[aa], 0);

        double [] Truth = new double[numDataTrain];
//datatrain prediction from the classifiers
        int predictAccuracy[]= new int[classifierNum];
        int confMatrix[][]= new int[4][classifierNum];
        for(int i=0;i<4;i++)
            Arrays.fill(confMatrix[i], 0);
        Arrays.fill(predictAccuracy, 0);
        double [][] ConfScore = new double[numDataTrain][classifierNum];
        int Prediction[][] = new int[numDataTrain][classifierNum];
        
        
//building the model        
        int checkImbalance=0;
        for (int i = 0; i < numDataTrain; i++) {
            Truth[i]=(int)datatrain.instance(i).value(datatrain.instance(i).numAttributes()-1);
            checkImbalance= checkImbalance +(int)Truth[i];
//probability, in binary : P_0 + P_1 = 1
            for(int p =0;p<classifierNum;p++){
                Prediction[i][p]= (int)fc[p].classifyInstance(datatrain.instance(i));
                if(Prediction[i][p]==Truth[i])
                    predictAccuracy[p]++;      
                if(Prediction[i][p]==Truth[i]){
                    if(Truth[i]==1) confMatrix[0][p]++;     //TP
                    else            confMatrix[1][p]++;     //TN
                }
                else{
                    if(Truth[i]==1) confMatrix[2][p]++;     //FN
                    else            confMatrix[3][p]++;     //FP
                }

                double[] TempProb = fc[p].distributionForInstance(datatrain.instance(i));
                ConfScore[i][p]=TempProb[1];    //take label 1's confidence score
//              prob[p]=TempProb[(int)pred[p]];
                if(ConfScore[i][p] == 1.0)
                    ConfScore[i][p]=0.999;
                Reliability[(int)Math.floor(ConfScore[i][p]/interval)][p]++; //divisor
                TruthReliability[(int)Math.floor(ConfScore[i][p]/interval)][p] = TruthReliability[(int)Math.floor(ConfScore[i][p]/interval)][p] + (int)Truth[i]; //dividend
          }
        }
//        checkImbalance = ((checkImbalance/numDataTrain)<0.2) ? 1 : 0;
        //"\tImbalance status : " + checkImbalance);
        checkImbalance=0;
        int idxClassifier=0;
        double AveAccuracy=0.0;
        double TrainAccuracy[]= new double[classifierNum];
        double KappaSensSpec[] = new double[classifierNum];
        double Fmeasure[] = new double[classifierNum];
        double CanberraDistance[] = new double[classifierNum];
        //find the best classifier accuracy
        for(int p=0;p<classifierNum;p++){
            double TP= (double)confMatrix[0][p],  TN= (double)confMatrix[1][p], 
                    FN= (double)confMatrix[2][p], FP= (double)confMatrix[3][p];
            double Po= (TP+TN)/(TP+TN+FP+FN);
            double Pe= ((TN+FP)*(FN+TN) + (FN+TP)*(FP+TP))/(numDataTrain*numDataTrain);           
            double TPR=TP/(TP+FN), TNR=TN/(TN+FP);
            KappaSensSpec[p]= (Po-Pe)/(1-Pe);
            KappaSensSpec[p]= (KappaSensSpec[p]+checkImbalance*(TPR+TNR)/2)/(java.lang.Math.pow(2,checkImbalance));
            Fmeasure[p]= (double)(2*TP)/(double)(2*TP+FP+FN);
            
            TrainAccuracy[p]= ((double)predictAccuracy[p]/numDataTrain);
            
            //accuracy
            CanberraDistance[p]=(1-TrainAccuracy[p])/(1+TrainAccuracy[p]);
            //Fmeasure;
            CanberraDistance[p]= CanberraDistance[p] + (1-Fmeasure[p])/(1+Fmeasure[p]);
            //Kappa;
            CanberraDistance[p]= CanberraDistance[p] + (1-KappaSensSpec[p])/(1+KappaSensSpec[p]);
            
            if(CanberraDistance[p]<CanberraDistance[idxClassifier])
                idxClassifier=p;
            
//            if(predictAccuracy[p]>predictAccuracy[idxClassifier])
//                idxClassifier=p;
            
            AveAccuracy = AveAccuracy + TrainAccuracy[p];
            report = report + "&emsp;&emsp;"+(p+1) + "&emsp; accuracy : " + TrainAccuracy[p] + 
                    "&emsp; KappaX : " + KappaSensSpec[p] + "<br/>";
        }
        
        AveAccuracy = AveAccuracy/classifierNum;
        report = report + "&emsp;Average: " + AveAccuracy + "<br/>";
        
//build the model    
        double model[][] = new double[numBin][classifierNum]; //reliability diagram for each model
        double interv[] = new double[numBin]; //the number of bin
        double AveLowInterv= 0.0,AveHighInterv= 0.0;
        int modelQ[][] = new int[numBin+1][classifierNum];
        Arrays.fill(modelQ[numBin], 0);
        for(int i =0;i<numBin;i++){               
            interv[i]=Math.round(interval*(i+1) * 100.0) / 100.0; //save the bin division
            
            if(i<(numBin/2))      AveLowInterv= AveLowInterv+interv[i];
            else                    AveHighInterv=AveHighInterv + interv[i];
            
            for(int p =0;p<classifierNum;p++){          //for each model, calculate empirical probability estimation
                double Empirical = 0.0;
                if(Reliability[i][p]!=0)
                    Empirical = (double)Math.round( ((double)TruthReliability[i][p]/Reliability[i][p]) * 1000.0) / 1000.0;                
                if(Empirical==0)
                    modelQ[i][p]=0;
                else if(interv[i]<=0.5)
                    modelQ[i][p]=(Empirical<=interv[i]-0.05) ? 1:-1;
                else if(interv[i]>0.5)
                    modelQ[i][p]=(Empirical>interv[i]-0.1) ? 1:-1;
                modelQ[numBin][p]=modelQ[numBin][p]+modelQ[i][p];
                model[i][p]=Empirical;
                //System.out.print(modelQ[i][p] + ",");
            }
            //System.out.println();
        }
        
report = report + "&emsp;&emsp;number of Bin : " +  numBin + "<br/>";
        //*save the average reliable probability
      //  double AverageReliable[] = new double[classifierNum];
        
report = report + "&emsp;&emsp;average value of Bin : " + (double)(AveLowInterv/(numBin/2)) + "&emsp;"+(double)(AveHighInterv/(numBin/2))+ "<br/>";
report = report + "Choose the recommended Algorithm(s)" + "<br/>";
        boolean[] recommended= new boolean[classifierNum];
        int numRecommended =0;
        Arrays.fill(recommended,false);
        for(int p =0;p<classifierNum;p++){
            recommended[p]=(modelQ[numBin][p]>limit ) ? true : false;

            if(recommended[p]==true){
                report = report + "&emsp;&emsp;classifier : " + (p+1) + " is recommended\t\t" + modelQ[numBin][p] + "<br/>";
                numRecommended++;
            }
            else
                report = report + "&emsp;&emsp;classifier : " + (p+1) + " is not recommended\t" + modelQ[numBin][p] + "<br/>";
            
        }
        
        if(numRecommended==0){
            numRecommended=1;
            recommended[idxClassifier]=true;
            report = report + "&emsp;&emsp;Classifier : " + (idxClassifier+1) + " is selected" + "<br/>";
        }
        endTime   = System.currentTimeMillis();
        totalTime = endTime - startTime;        
        report = report + "Reliable Diagram time: " + separator + totalTime + separator + " ms" + "<br/>";

report = report + "<br/>Start to predict:" + "<br/>";
//predicting
        
        int basePrediction[][] = new int[numDataTest][classifierNum];
        double baseConfscore[][] = new double[numDataTest][classifierNum];
        int[] RMVPredict = new int[numDataTest];
        double[] RMV2Predict = new double[numDataTest];
        int[] MVPredict = new int[numDataTest];
        double[] WMVPredict = new double[numDataTest];
        
        int RMVmatrix[] = new int[4];
        int RMV2matrix[] = new int[4];
        int MVmatrix[] = new int[4];
        int WMVmatrix[] = new int[4];
        
        RMVmatrix[0] = RMVmatrix[1] = RMVmatrix[2] = RMVmatrix[3]= 0;
        RMV2matrix[0] = RMV2matrix[1] = RMV2matrix[2] = RMV2matrix[3]= 0;
        MVmatrix[0] = MVmatrix[1] = MVmatrix[2] = MVmatrix[3]= 0;
        WMVmatrix[0] = WMVmatrix[1] = WMVmatrix[2] = WMVmatrix[3]= 0;
        
        
        String folderOutput =this.test;
        FileWriter Xvali = new FileWriter(folderOutput + "X-vali.txt");
        FileWriter Ybvali = new FileWriter(folderOutput + "Yb-vali.txt");
        FileWriter Ybis = new FileWriter(folderOutput + "Y.txt");
        FileWriter Entropy = new FileWriter(folderOutput + "entropy_input_EM.txt");
        
        double[] RMVConfscore = new double[numDataTest];
        Arrays.fill(RMVPredict,0);
        Arrays.fill(RMV2Predict,0.0);
        
        for(int i=0;i<4;i++)
            Arrays.fill(confMatrix[i], 0);
        
        int[] TruthTest = new int[numDataTest];
        int numAttribute = datatest.numAttributes();
        for (int i = 0; i < numDataTest; i++) {
            TruthTest[i]=(int)datatest.instance(i).value(numAttribute-1);    
            Ybvali.append(TruthTest[i] + "\n");               
            
            for(int k=0;k<(numAttribute-1);k++){
                Xvali.append(datatest.instance(i).value(k) + " ");
            }
            Xvali.append("\n");
            
            //prediction: 0 or 1
            int status=0;
            for(int p =0;p<classifierNum;p++){
                basePrediction[i][p]= (int)fc[p].classifyInstance(datatest.instance(i));
                
                if(p==idxClassifier)
                   Entropy.append(basePrediction[i][p] + "\n");               
             
                MVPredict[i]= MVPredict[i]+basePrediction[i][p];
                
                double[] TempProb = fc[p].distributionForInstance(datatest.instance(i));
                WMVPredict[i]= WMVPredict[i]+ TempProb[1];  //take label 1's confidence score
                
                if(recommended[p]==true){              
                    RMVPredict[i]= RMVPredict[i]+basePrediction[i][p];
                    RMV2Predict[i]= RMV2Predict[i]+ TempProb[1];  //take label 1's confidence score 
                    Ybis.append(basePrediction[i][p] + " ");                  
                }
                if(basePrediction[i][p]==TruthTest[i]){
                    if(TruthTest[i]==1) confMatrix[0][p]++;     //TP
                    else            confMatrix[1][p]++;     //TN
                }
                else{
                    if(TruthTest[i]==1) confMatrix[2][p]++;     //FN
                    else            confMatrix[3][p]++;     //FP
                }
            }
            Ybis.append("\n"); 
//RMV            
            if((int)(RMVPredict[i]/numRecommended)==TruthTest[i]){
                if(TruthTest[i]==1) RMVmatrix[0]++;     //TP
                else            RMVmatrix[1]++;     //TN
            }
            else{
                if(TruthTest[i]==1) RMVmatrix[2]++;     //FN
                else            RMVmatrix[3]++;     //FP
            }
//MV            
            if((int)(MVPredict[i]/classifierNum)==TruthTest[i]){
                if(TruthTest[i]==1) 
                    MVmatrix[0]++;     //TP
                else            MVmatrix[1]++;     //TN
            }
            else{
                if(TruthTest[i]==1) MVmatrix[2]++;     //FN
                else            MVmatrix[3]++;     //FP
            }
//WMV       
            int WMV= ((WMVPredict[i]/(double)classifierNum)>0.5)?1:0;            
                    
            if(WMV==TruthTest[i]){
                if(TruthTest[i]==1) WMVmatrix[0]++;     //TP
                else            WMVmatrix[1]++;     //TN
            }
            else{
                if(TruthTest[i]==1) WMVmatrix[2]++;     //FN
                else            WMVmatrix[3]++;     //FP
            }
//RMV2       
            int RMV2= ((RMV2Predict[i]/(double)numRecommended)>0.5)?1:0;            
                    
            if(RMV2==TruthTest[i]){
                if(TruthTest[i]==1) RMV2matrix[0]++;     //TP
                else            RMV2matrix[1]++;     //TN
            }
            else{
                if(TruthTest[i]==1) RMV2matrix[2]++;     //FN
                else            RMV2matrix[3]++;     //FP
            }            
            
        }
        
        Xvali.flush();
        Xvali.close(); 
        Ybvali.flush();
        Ybvali.close(); 
        Ybis.flush();
        Ybis.close();  
        Entropy.flush();
        Entropy.close(); 
        
//call R
        Rconnect Rconnect = new Rconnect(folderOutput, "0.1", "0.65", "1");
        String SFCresult = Rconnect.getResult();
        
        
        report = report + " RDlimit:" + limit +" accuracy TPR TNR Kappa KappaX RD" + "<br/>";
        int y=0;
        for(int i=0;i<this.nClassifier;i++){
            if(algo[i]==true){
                this.setConfusionMatrix(this.getConfusionMatrix() + confMatrix[0][y] + ";" + confMatrix[1][y] + ";" + confMatrix[2][y] + ";" + confMatrix[3][y] + "@@");
                y++;
            }
            else
                this.setConfusionMatrix(this.getConfusionMatrix() + "-;-;-;-@@");
        }
        
        this.setConfusionMatrix(this.getConfusionMatrix() + RMVmatrix[0] + ";" + RMVmatrix[1] + ";" + RMVmatrix[2] + ";" + RMVmatrix[3] + "@@");
        this.setConfusionMatrix(this.getConfusionMatrix() + MVmatrix[0] + ";" + MVmatrix[1] + ";" + MVmatrix[2] + ";" + MVmatrix[3] + "@@");
        this.setConfusionMatrix(this.getConfusionMatrix() + WMVmatrix[0] + ";" + WMVmatrix[1] + ";" + WMVmatrix[2] + ";" + WMVmatrix[3] + "@@");
        this.setConfusionMatrix(this.getConfusionMatrix() + RMV2matrix[0] + ";" + RMV2matrix[1] + ";" + RMV2matrix[2] + ";" + RMV2matrix[3] + "@@");
        this.setConfusionMatrix(this.getConfusionMatrix() + SFCresult);
        
        for(int p=0;p<classifierNum;p++){
            if(recommended[p]==true){
                report = report + "***";
            }
            double TP= (double)confMatrix[0][p],  TN= (double)confMatrix[1][p], 
                    FN= (double)confMatrix[2][p], FP= (double)confMatrix[3][p];
            double Po= (TP+TN)/(TP+TN+FP+FN);
            double Pe= ((TN+FP)*(FN+TN) + (FN+TP)*(FP+TP))/(numDataTrain*numDataTrain);           
            double accuracy =(TP + TN)/(TP+TN+FP+FN);
            double TPR=TP/(TP+FN), TNR=TN/(TN+FP);
            double Kappa= (Po-Pe)/(1-Pe);
            double KappaX= (Kappa+checkImbalance*(TPR+TNR)/2)/(java.lang.Math.pow(2,checkImbalance));
            
                report = report + "&emsp;&emsp;" + (p+1) + ".&emsp;&emsp;" + 
                        String.format("%.3f", accuracy) + "&emsp;&emsp;"
                        + String.format("%.3f", TPR) + "&emsp;&emsp;"
                        + String.format("%.3f", TNR) + "&emsp;&emsp;"
                        + String.format("%.3f", Kappa) + "&emsp;&emsp;"
                        + String.format("%.3f", KappaX) + "&emsp;&emsp;"
                        + modelQ[numBin][p] + "&emsp;&emsp;"
                + "&emsp;&emsp;TP: " + confMatrix[0][p]  + "&emsp;&emsp;TN: " + confMatrix[1][p]  + 
                        "&emsp;&emsp;FP: " + confMatrix[3][p]  + "&emsp;&emsp;FN: " + confMatrix[2][p]+ "<br/>";
        }
        
        double TP= (double)RMVmatrix[0],  TN= (double)RMVmatrix[1], FN= (double)RMVmatrix[2], FP= (double)RMVmatrix[3];            
        double Po= (TP+TN)/(TP+TN+FP+FN);
        double Pe= ((TN+FP)*(FN+TN) + (FN+TP)*(FP+TP))/(numDataTrain*numDataTrain);           
        double accuracy =(TP + TN)/(TP+TN+FP+FN);          
        double TPR=TP/(TP+FN), TNR=TN/(TN+FP);
        double Kappa= (Po-Pe)/(1-Pe);
        double KappaX= (Kappa+checkImbalance*(TPR+TNR)/2)/(java.lang.Math.pow(2,checkImbalance));
        report = report + "&emsp;&emsp; RMV " + 
                        String.format("%.3f", accuracy) + "&emsp;&emsp;"
                        + String.format("%.3f", TPR) + "&emsp;&emsp;"
                        + String.format("%.3f", TNR) + "&emsp;&emsp;"
                        + String.format("%.3f", Kappa) + "&emsp;&emsp;"
                        + String.format("%.3f", KappaX) + "&emsp;&emsp;&emsp;&emsp;"
        + "&emsp;&emsp;TP: " + RMVmatrix[0]  + "&emsp;&emsp;TN: " + RMVmatrix[1] + "&emsp;&emsp;FP: " 
                + RMVmatrix[3]  + "&emsp;&emsp;FN: " + RMVmatrix[2]+ "<br/>";      
        
        TP= (double)MVmatrix[0];  TN= (double)MVmatrix[1]; FN= (double)MVmatrix[2]; FP= (double)MVmatrix[3];            
        Po= (TP+TN)/(TP+TN+FP+FN);
        Pe= ((TN+FP)*(FN+TN) + (FN+TP)*(FP+TP))/(numDataTrain*numDataTrain);           
        accuracy =(TP + TN)/(TP+TN+FP+FN);          
        TPR=TP/(TP+FN); TNR=TN/(TN+FP);
        Kappa= (Po-Pe)/(1-Pe);
        KappaX= (Kappa+checkImbalance*(TPR+TNR)/2)/(java.lang.Math.pow(2,checkImbalance));
        report = report + "&emsp;&emsp; MV " + 
                        String.format("%.3f", accuracy) + "&emsp;&emsp; "
                        + String.format("%.3f", TPR) + "&emsp;&emsp; "
                        + String.format("%.3f", TNR) + "&emsp;&emsp; "
                        + String.format("%.3f", Kappa) + "&emsp;&emsp; "
                        + String.format("%.3f", KappaX) + "&emsp;&emsp; &emsp;&emsp; "
        + "&emsp;&emsp; TP: " + MVmatrix[0]  + "&emsp;&emsp; TN: " + MVmatrix[1] + "&emsp;&emsp; FP: "
                + MVmatrix[3]  + "&emsp;&emsp; FN: " + MVmatrix[2]+ "<br/>";        
        
        TP= (double)WMVmatrix[0];  TN= (double)WMVmatrix[1]; FN= (double)WMVmatrix[2]; FP= (double)WMVmatrix[3];            
        Po= (TP+TN)/(TP+TN+FP+FN);
        Pe= ((TN+FP)*(FN+TN) + (FN+TP)*(FP+TP))/(numDataTrain*numDataTrain);           
        accuracy =(TP + TN)/(TP+TN+FP+FN);          
        TPR=TP/(TP+FN); TNR=TN/(TN+FP);
        Kappa= (Po-Pe)/(1-Pe);
        KappaX= (Kappa+checkImbalance*(TPR+TNR)/2)/(java.lang.Math.pow(2,checkImbalance));
        report = report + "&emsp;&emsp; WMV " + 
                        String.format("%.3f", accuracy) + "&emsp;&emsp; "
                        + String.format("%.3f", TPR) + "&emsp;&emsp; "
                        + String.format("%.3f", TNR) + "&emsp;&emsp; "
                        + String.format("%.3f", Kappa) + "&emsp;&emsp; "
                        + String.format("%.3f", KappaX) + "&emsp;&emsp; &emsp;&emsp; "
        + "&emsp;&emsp; TP: " + WMVmatrix[0]  + "&emsp;&emsp; TN: " + WMVmatrix[1] + "&emsp;&emsp; FP: " 
                + WMVmatrix[3]  + "&emsp;&emsp; FN: " + WMVmatrix[2]+ "<br/>";        
        
        TP= (double)RMV2matrix[0];  TN= (double)RMV2matrix[1]; FN= (double)RMV2matrix[2]; FP= (double)RMV2matrix[3];            
        Po= (TP+TN)/(TP+TN+FP+FN);
        Pe= ((TN+FP)*(FN+TN) + (FN+TP)*(FP+TP))/(numDataTrain*numDataTrain);           
        accuracy =(TP + TN)/(TP+TN+FP+FN);          
        TPR=TP/(TP+FN); TNR=TN/(TN+FP);
        Kappa= (Po-Pe)/(1-Pe);
        KappaX= (Kappa+checkImbalance*(TPR+TNR)/2)/(java.lang.Math.pow(2,checkImbalance));
        report = report + "&emsp;&emsp; RMV2 " + 
                        String.format("%.3f", accuracy) + "&emsp;&emsp; "
                        + String.format("%.3f", TPR) + "&emsp;&emsp; "
                        + String.format("%.3f", TNR) + "&emsp;&emsp; "
                        + String.format("%.3f", Kappa) + "&emsp;&emsp; "
                        + String.format("%.3f", KappaX) + "&emsp;&emsp; &emsp;&emsp; "
        + "&emsp;&emsp; TP: " + WMVmatrix[0]  + "&emsp;&emsp; TN: " + WMVmatrix[1] + "&emsp;&emsp; FP: " + 
                WMVmatrix[3]  + "&emsp;&emsp; FN: " + WMVmatrix[2]+ "<br/>";        
                       
        this.report = report;
        for(int i=0;i<this.nClassifier;i++)
            this.options = this.options + options[i] + "@@";
        
        this.options= this.options + " @@";
        this.options= this.options + " @@";
        this.options= this.options + " @@";
        this.options= this.options + " @@";
        this.options= this.options + " @@"; 
        
        
        //delete dataset
        File file = new File(this.train);
        if(file.delete())
            System.out.println("File deleted successfully");
        else
            System.out.println("Failed to delete the file");
        
        file = new File(this.test);
        if(file.delete())
            System.out.println("File deleted successfully");
        else
            System.out.println("Failed to delete the file");

        
    }
    
//read your file, p.s. weka is only for single label learning, that is why you must set the class index
    private static Instances ReadFile(String fileAddress) {
        Instances data = null;
        
        weka.core.converters.ConverterUtils.DataSource source;
        try {
            source = new weka.core.converters.ConverterUtils.DataSource(fileAddress);
            data = source.getDataSet();
            
            // setting class attribute in the last of attribute
            if(data.classIndex() == -1)
                data.setClassIndex(data.numAttributes() - 1);
        } catch (Exception ex) {
            System.err.println("data can't be read because of this error :" + ex);
        }
        
        return data;
    }
    
    private static double Prob(double[] Prob) {
          if(Prob[0]>Prob[1])
              return Prob[0];
          else
              return Prob[1];
    }

    /**
     * @return the report
     */
    public String getReport() {
        return report;
    }

    /**
     * @param report the report to set
     */
    public void setReport(String report) {
        this.report = report;
    }

    /**
     * @return the options
     */
    public String getOptions() {
        return options;
    }

    /**
     * @param options the options to set
     */
    public void setOptions(String options) {
        this.options = options;
    }

    /**
     * @return the ConfusionMatrix
     */
    public String getConfusionMatrix() {
        return ConfusionMatrix;
    }

    /**
     * @param ConfusionMatrix the ConfusionMatrix to set
     */
    public void setConfusionMatrix(String ConfusionMatrix) {
        this.ConfusionMatrix = ConfusionMatrix;
    }

}
