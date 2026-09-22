%EffectSize Analysis Code Cody Hubbard% d(n).title = "paper title", 
% d(n).task_or_stain = "task or stain"
% d(n).comp = "comparison information (i.e.,
% sham 1 vs injury 1" for the first comparison, if a paper has multiple
% comparisons (such as during morris water maze experiments), then after
% the first comp it takes the form d(n).comp(1+n) = "comparison
% information", 
% and the effect sizes d(n).comp(n) = ApproxCohen(values). If
% an effect size is uncalculable, then put NaN.
%note to self make a d(i).anyEffects = 1 or 0; where 1 means an effect
%could be counted for at least one paper and 0 means none at all.
%common acronyms MBP (myeblin basic protein), TST (tail suspension test),
%FST (forced swim test), NOR (novel object recognition), MWM (Morris water
%Maze), BM (Barnes maze), NSS (neurological symptom severity), DCX (double
%cortin)
% d.hitcount is the total number of impacts
% d.hitinterval is the inter-impact interval
% d.timepoints is given in the order of time most temporally proximal to injury to
% most distal
%d.modelstat = 1 for free fall/modified wayne state-like models and 0 =
%Fixed Surface Weight Drop (WD)/no free fall component models
% d.heightinCM is the height of the weight drop in cm
% d.weightinGrams is the weight dropped in grams
% d.anesthesiatype is the type of anesthesia and dose 
% d.freeFallStat = 1 for yes, 0 for no, 2 not described
% d.scalpopenstat = 1 for yes, 0 for no, and 2 if not described (important
% because some papers with helmets don't necessarily do surgery)
% d.helmetstat = 1 for yes, 0 for no, and 2 if not described
% d.impactorchar = will be the diameter of the weight or Na if not
% reported
% d.helmetchar = will be the [diameter and thickness units] in  or not described
% they use a helmet but don't give its properties or NA if doesn't apply
% based on the model
% d.mar_likeplatform =  will be a description or NA
% d.freefallplatform = will be a description or NA
% d.impactLocation = 1 if the impact is along the midline UNhelmeted, 0 if
% the impact is along the midline helmeted, 3 if the impact is lateralized
% UNhelmeted, 2 if the impact is lateralized helmeted, 4 if there is not enough information and the model is helmeted or Unhelmeted followed by the statement
% d.species = 1 if a rat, 0 if a mouse
% d.strain  = 1 = sprague, 2 = long evans, 3 = wistar, 4 = wistar albinos,
% 5 = piebald viral glaxo (PVG), 6 = N-MARI 
% (all rats)// 7 = any c57BL/6-type, 8 = CD-1, 9 = swiss webster, 10 CF-1, 11 = ICR,
% 12 = NMRI (mice), 13 = albion BABL or BALB, 14 = ddY, 15 = Swiss
% 16 = not described at all
% d.animalsex = 0 = only male, 1 = only female, 2 = both female and male, 3
% = not described
% d.developmentstat = a statement
% d.animalweights  (in grams)  = given as a range if the vector is 2
% numbers [lower and upper] and given a mean and variance if the vector is
% 3 numbers [mean-var, mean, mean+variance], or "not given"
% d.IHCmethod = method used
% d.IHC_staindilutions = stain then dilution or % in the case of fluorjade
% b, c, cresyl violet/nissl, H&E, silver stain
% d.brain_regionList = vector of brain regions used
% d.rightTime = 0 if there is a positive report (injury group took longer
% to get up), 1 if there is a negative report (states no difference), 2 if
% the report is mixed (meaning multiple injuries that are not consistent in
% inducing righting time deficits), 3 if there is no report or not reported
% in a comparative manner (i.e. "all animals regained righting reflex in x
% minutes").
% d.neg_outcomes = a statement of negative outcomes 
% d.supplementStat = 1 if there is supplementary information, 0 if no
% d.Data_availabilitystatement = 0 if there no statement, 
% 1 if there is a reported statement and the data is available (link to repository or place to obtain the data),
% 2 if there is a statement and data is available upon request to the authors, 
% 3 if there is a statement and the authors state there is enough information in the supplement and article to evaluate the results, 
% 4 if there is a
% statement and/or it is upon request to the authors or something along those
% lines
% 4 if the articles says data availability does not apply
% 5 if it falls under "extended data"
%d.nhpTest = 1 if yes and 0 if no
%d().rightTimeEffect = effect size for righting time
%d().LackrightTimeEffect = reason why it is not calculable
%d().rightTimeDir        = was the tbi group higher, lower, not different,
%or mixed if multiple injuries
%d().NHPSigLevel   = the most conservative p-value used the default
%is a pvalue(s) and other types will be denoted as they arise
%there are d(). variablenames for extra information such as
%Lack_effectValEx, note and other variables to signify additional
%information as to why an effect could not be calculated or why a a paper
%is only looking at a portion of the groups (such as in the case of papers
%with groups with greater than 10% mortality).


%%%%%
%%%%%
%%%%%
%%%%%
% Please note many of the graphs were not used for the final publication in
% favor of tables, but the graphs are left for historical documentation
% purposes. Additionally, some of the analysis may also be found at the end
% of the database code.
%%%%%
%%%%%
%%%%%
%%%%%



RED      = [0.90 0.00 0.15 ];
MAGENTA  = [0.80 0.00 0.80 ];
ORANGE   = [1.00 0.50 0.00 ];
YELLOW   = [1.00 0.68 0.26 ];
GREEN    = [0.09 0.45 0.27 ];
CYAN     = [0.28 0.82 0.80 ];
BLUE     = [0.00 0.00 1.00 ];
BLACK    = [0.00 0.00 0.05 ];
RUST     = [.65  0.20 0.03 ];
GREY     = [0.7  0.7   0.7 ];
EffectSize_Database_num1B; % <<--- future users, please use this data base

ImpactCharWasNotGivenSum = sum(ImpactCharNotExists);
ImpactCharWasGivenSum = sum(ImpactCharExists);

HelmetCharWasNotGivenSum     = sum(HelmetCharNotDescribed);
HelmetCharWasPartialGivenSum = sum(HelmetCharVague);
HelmetCharWasGivenSum        = sum(HelmetCharGiven);

FixedSurfaceNotDescribedSum = sum(FixedSurfNotDesc);
FixedSurfaceCushionSum = sum(FixedSurfaceCushion);
FixedSurfaceHardSum = sum(FixedSurfaceHardImmobile);




for i = 1:length(d)
if d(i).ModelStat == 1 && d(i).Species == 1
    RatFreeFallCount(i) = 1;
elseif d(i).ModelStat == 1 && d(i).Species == 0
    MouseFreeFallCount(i) = 1;
elseif d(i).ModelStat == 0 && d(i).Species == 1
    RatFixedSurfaceCount(i) = 1;
elseif d(i).ModelStat == 0 && d(i).Species == 0
    MouseFixedSurfaceCount(i) = 1;
end
end
TotalRatFF   = sum(RatFreeFallCount);
TotalMouseFF = sum(MouseFreeFallCount);
TotalRatFS   = sum(RatFixedSurfaceCount);
TotalMouseFS = sum(MouseFixedSurfaceCount);

hitCountTotalPapers = sum(hitCountCounter);

Papers_W_NoAnimalWeight = sum(noAnimalweightgiven);

clear i 
for i =1:length(d)
    ImpactLocaCat(i) = str2num(d(i).impact_location(1));
end
PaperwithExtra_Impact = str2num(d(196).impact_location(2));

clear i
for i = 1:length(d) %done
    if ImpactLocaCat(i) == 0
        MidHelm(i) = 1;
    elseif ImpactLocaCat(i) == 1
        MidUnHelm(i) = 1;
    elseif ImpactLocaCat(i) == 2
        LatHelm(i) = 1;
    elseif ImpactLocaCat(i) == 3
        LatUnHelm(i) = 1;
    elseif ImpactLocaCat(i) == 4
        NotEnoInfo(i) = 1;
    end
end
summedMidHelm    = sum(MidHelm);
summedMidUnHelm  = sum(MidUnHelm);
summedLatHelm    = sum(LatHelm);
summedLatUnHelm  = sum([LatUnHelm PaperwithExtra_Impact]);
summedNotEnoInfo = sum(NotEnoInfo);



clear i
for i = 1:length(d) %done
    if d(i).Data_availabilityStat == 0
        NoDataStat(i) = 1;
    elseif d(i).Data_availabilityStat == 1
        YesDataAndGives(i) = 1;
    elseif d(i).Data_availabilityStat == 2
        YesUponReq(i) = 1;
    elseif d(i).Data_availabilityStat == 3
        SaysEnoughToEval(i) = 1;
    elseif d(i).Data_availabilityStat == 4
        SaysDoesntApp_or_uponReq(i) = 1;
    elseif d(i).Data_availabilityStat == 5
        SaysExtendData(i) = 1;
  
    end
end
sumNoData           = sum(NoDataStat);
sumYesDataGives     = sum(YesDataAndGives);
sumYesupReq         = sum(YesUponReq);
sumSaysEnoughtoEval = sum(SaysEnoughToEval);
sumDoesntApp        = sum(SaysDoesntApp_or_uponReq);
sumExtendData       = sum(SaysExtendData);

%simplfying the supp stats: into not reported, data is available, and 
% SumNOTREP  = sumNoData
% SumYESDATA = sumYesDataGives
% SumREQME   = sum([sumYesupReq sumSaysEnoughtoEval SaysDoesntApp_or_uponReq ])


clear i
for i = 1:length(d) %done
    if d(i).SupplementStat == 1
        SuppYes(i) = 1;
    elseif d(i).SupplementStat == 0
        SuppNo(i) = 1;
    end
end
sumSuppYes = sum(SuppYes);
sumSuppNo   = sum(SuppNo);



clear i
for i = 1:length(d) 
    if d(i).ModelStat == 1
        FreefallCount(i) = 1;
    elseif d(i).ModelStat == 0
        MarmarCount(i) = 1;
    end
end
sumFreefall = sum(FreefallCount);
sumMarmar   = sum(MarmarCount);

clear i
clear c
for i = 1:length(d) %done
    if d(i).anesthesiaCat == 0
        discrepancyAnes(i) = 1;

    elseif d(i).anesthesiaCat == 1
        NoTypeAnes(i) = 1;
    elseif d(i).anesthesiaCat == 2
        IsoNoAnes(i) = 1;
    elseif d(i).anesthesiaCat == 3
        EtherNoAnes(i) = 1;
    elseif d(i).anesthesiaCat == 4
        HaloNoAnes(i) = 1;
    elseif d(i).anesthesiaCat == 5
        PentoNoAnes(i) = 1;
    elseif d(i).anesthesiaCat == 6
        KetXyNoAnes(i) = 1;
    elseif d(i).anesthesiaCat == 7
        ChloralHyNoAnes(i) = 1;
    elseif d(i).anesthesiaCat == 8
        IsoYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 9
        ThiopenYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 10
        TribroYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 11
        KetXyYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 12
        HaloYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 13
        EtherYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 14
        NitroOxyYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 15
        ChloralHyYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 16
        KetChlorYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 17
        ZoXylYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 18
        MidazYesAnes(i) = 1; % midaz and med
    elseif d(i).anesthesiaCat == 19
        SevoYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 20
        KetMedYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 21
        KetMidazYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 22
        AverYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 23
        TiletamZoYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 24
        ZolXylYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 25
        FluaFentMidazYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 26
        FentMidazMedYesAnes(i) = 1;
    elseif d(i).anesthesiaCat == 27
        SodPentYesAnes(i) = 1;

    end
end

summedDisc             = sum(discrepancyAnes);
summedNoType           = sum(NoTypeAnes);
summedIsoNo            = sum(IsoNoAnes);
summedEtherNo          = sum(EtherNoAnes);
summedHaloNo           = sum(HaloNoAnes);
summedPentoNo          = sum(PentoNoAnes);
summedKeyXyNo          = sum(KetXyNoAnes);
summedChloralHyNo      = sum(ChloralHyNoAnes);
summedIsoYes           = sum(IsoYesAnes);
summedThiopenYes       = sum(ThiopenYesAnes);
summedTribroYes        = sum(TribroYesAnes);
summedKetXyYes         = sum(KetXyYesAnes);
summedHaloYes          = sum(HaloYesAnes);
summedEtherYes         = sum(EtherYesAnes);
summedNitroOxyYes      = sum(NitroOxyYesAnes);
summedChloralHyYes     = sum(ChloralHyYesAnes);
summedKetChlorYes      = sum(KetChlorYesAnes);
summedZoXylYes         = sum(ZoXylYesAnes); %zoletil xylani and atropine
summedMidazYes         = sum(MidazYesAnes);
summedSevoYes          = sum(SevoYesAnes);
summedKetMedYes        = sum(KetMedYesAnes);
summedKetMidazYes      = sum(KetMidazYesAnes);
summedAverYes          = sum(AverYesAnes);
summedTiletamZoYes     = sum(TiletamZoYesAnes);
summedZolXylYes        = sum(ZolXylYesAnes);
summedFluaFentMidazYes = sum(FluaFentMidazYesAnes);
summedFentMidazMedYes  = sum(FentMidazMedYesAnes);
summedSodPentYes       = sum(SodPentYesAnes);


clear i
for i = 1:length(d) %done
    if d(i).Species == 1
        Rat_Studies(i) = 1;
    elseif d(i).Species == 0
        Mouse_Studies(i) = 1;
    end
end
NumRats = sum(Rat_Studies);
NumMice = sum(Mouse_Studies);


clear i
for i = 1:length(d) %done
    if d(i).Animal_sex == 0
        MaleOnly(i) = 1;
    elseif d(i).Animal_sex == 1
        FemOnly(i) = 1;
    elseif d(i).Animal_sex == 2
        BothFem_Male(i) = 1;
    elseif d(i).Animal_sex(1) == 3
        Sex_NotDesc(i) = 1;
    end
end
NumMales       = sum(MaleOnly);
NumFemales     = sum(FemOnly);
NumBothM_F     = sum(BothFem_Male);
NumSex_NotDesc = sum(Sex_NotDesc);


clear i
clear c
for i = 1:length(d) %done
    for c = 1:length(d(i).Strain)
        if d(i).Strain(c) == 1
            Sprague(i) = 1;
        elseif d(i).Strain(c) == 2
            LongEvan(i) = 1;
        elseif d(i).Strain(c) == 3
            Wistar(i) = 1;
        elseif d(i).Strain(c) == 4
            WistarAlbino(i) = 1;
        elseif d(i).Strain(c) == 5
            PVG(i) = 1;
        elseif d(i).Strain(c) == 6
            N_MARI(i) = 1;
        elseif d(i).Strain(c) == 7
            C57Black(i) = 1;
        elseif d(i).Strain(c) == 8
            CD_1(i) = 1;
        elseif d(i).Strain(c) == 9
            SwissWeb(i) = 1;
        elseif d(i).Strain(c) == 10
            CF_1(i) = 1;
        elseif d(i).Strain(c) == 11
            ICR(i) = 1;
        elseif d(i).Strain(c) == 12
            NMRI(i) = 1;
        elseif d(i).Strain(c) == 13
            BALB(i) = 1;
        elseif d(i).Strain(c) == 14
            DDY(i) = 1;
        elseif d(i).Strain(c) == 15
            Swiss(i) = 1;
        elseif d(i).Strain(c) == 16
            StrainNotDesc(i) = 1;
        end
    end
end

summedSprague           = sum(Sprague);
summedLongEvan          = sum(LongEvan);
summedWistar            = sum(Wistar);
summedWistarAlbino      = sum(WistarAlbino);
summedPVG               = sum(PVG);
summedN_MARI            = sum(N_MARI);
summedC57Black          = sum(C57Black);
summedCD_1              = sum(CD_1);
summedSwissWeb          = sum(SwissWeb);
summedCF_1              = sum(CF_1);
summedICR               = sum(ICR);
summedNMRI              = sum(NMRI);
summedBALB              = sum(BALB);
summedDDY               = sum(DDY);
summedSwiss             = sum(Swiss);
summedStrainNotDesc     = sum(StrainNotDesc);



papersWithEffects = length(papersWith_noeffects) - sum(papersWith_noeffects); %57 papers with at least 1 effect size based soley on sham vs control comparisons


%behavioral paradigm names
Behavioral_names = ["Open Field Test" "Y-Maze" "Novel Object Recognition paradigms" "Elevated Plus Maze"  ...
    "Locomotor Activity" "Rotarod" "Forced Swim Test" "Spontaneous Forelimb Elevation" "Beam Walk Test"  ...
    "Von Frey" "Resident Intruder" "Tail Suspension Test" "3 Chamber Sociality Test" "Neurological Assessments"  ...
    "Morris Water Maze Paradigms" "Barnes Maze" "2-Bottle Choice Paradigms" "Hyperemotionality Score" "5 Choice Serial Reaction Time Paradigms" "Wire Hang Test"  ...
    "Optomotor (Optokinetic) Response" "Voluntary Wheel Running" "CatWalk" "Erasmus Ladder" "Grip Strength" "Treadmill Paradigms" "Marble Burying"  ...
    "Nestlet Shredding" "Homecage Monitoring Systems" "Socio-Sexual Interaction" "Social Interaction" "Conditioned Passive Avoidance and Light-Dark Test" ...
    "Pole Climb Test" "Adhesive Removal Test" "Rotating Pole Test" "Water Finding Task" "Wire Grip" "Beam Balance Test" "Formalin Test"  ...
    "Mechanical Allodynia (Dynamic Plantar Aesthesiometer)" "Thermal Hyperalgesia (Plantar Test Apparatus)" "Bussey-Saksida Box For Cognitive Testing" ...
    "Conditioned Place Preference" "Inclined Plane Test" "Developmental Milestone Task" "Ultrasonic Vocalization" "Footprint Test" "Staircase Test" "Hotplate Test" "Dry Maze" "Social Preference Test" ...
    "Social Novelty" "Grip Strength" "Empathy-like Behavior" "Sudden Immobilization Behavior" "Grid Walking" "Tail Flick" ...
    "Elevated Zero Maze" "Novelty Suppressed Feeding" "8-Arm Radial Maze" "Limb Clasping Test" "Traverse Beam Test" "Seeking Behavior" "Circle Exiting" "Time to Seek" "Hole Board Test" "Foot Fault Test" "T-Maze and Swim T-Maze"...
    "Step Down Inhibitory Avoidance Task" "Orofacial Pain Assessment Device (OPAD)" "Social Play Fighting" "Touchscreen Chamber for Location Discrimination" "Resistance to Capture" "Dark-Light Test" "Pole Test" "Fatigue Test"...
    "Sensorimotor Deficit Score" "Self Grooming" "Activity Monitoring" "Social Odor Based Novelty" "Splash Test" "Nest Building" "Fear Conditioning"];

%reduced behavioral paradigm names based on paradigms with at least 1
%effect size
NewBehavioral_names = [Behavioral_names(1:7) Behavioral_names(9:17) Behavioral_names(21) Behavioral_names(27:30) Behavioral_names(32) Behavioral_names(36) Behavioral_names(40:41)  Behavioral_names(48) Behavioral_names(56) Behavioral_names(59) Behavioral_names(66) Behavioral_names(72) Behavioral_names(81)];
%Behavioral_names(46) place between (40:41) and (48) if you want to
%visualize female only (original paper doesn't have approp groups for this
%stain or tissue based paradigms
Stain_names = ["GFAP" "IBA1" "P-Tau" "CC1" "RBFOX3/NeuN" "Hoechst" "Fluorjade-C" "NeuN" "TNF-a/IBA1" "Fluorojade-B/NeuN" "Cresyl Violet/Nissl" "F-Actin" "Beta Tubulin 3" "P38 MAPk"...
    "PECAM-1" "H&E" "VEGF" "Luxol Fast MAGENTA" "Fluorojade-B" "Silver Stain Preparations" "IgG" "8OHdG" "Hypoxyprobe" "Hypoxyprobe/NeuN"  ...
    "HDAC4" "HDAC5" "HSP70" "Beta-APP" "CB2" "ILB4" "Tyrosine Hydroxylase" "IBA1/TNF-a" "MAP2/PSD-95" "MAP2/Synaptophysin" "APP" "E-Cadherin" "Myelin Basic Protein" ...
    "H&E/Cresyl Violet/Nissl" "Prussian MAGENTA" "CD68" "CD206" "BrdU" "Vimentin" "Nestin" "Glt1" "Kir4.1" "Cleaved Caspase 3 and Caspase 3" "S100B" "S100" "CD11b" "Ki87" "Anti-Human Tau" "Connexin43" "Glutamine Synthetase" "Biocytin" "Amyloid Beta (4G8 anti-ABETA17-24)" ...
     "DAPI" "Amyloid Beta" "MC1" "Gamma Synuclein"  ...
    "Toluidine MAGENTA" "Lucifer Yellow" "FITC-albumin" "Evans MAGENTA" "HNE" "MnSOD" "Luxol Fast MAGENTA and Cresyl Violet" "Caspr (paranodes)" "Olig2/NG2" "3NT" "8-OHG" ...
    "SOD2" "BID" "Substance P" "NK1" "OPA1" "Cadaverine" "ZO-1" "GLUT1" "CD45" "Beta-Dystroglycan" "AQP4" "Golgi Cox and Golgi Preparations"...
    "Oligo2" "Reelin" "CXCR4" "PAR-1" "BDNF" "TDP-43" "ChAT" "TUNEL" "Beta-Actin" "Nrf2" "Catalase" "Glutathione" "Thioredoxin" "Superoxide Dismutase 1" "p-CREB" "TUNEL/APP" "p75ntr/NeuN"...
    "p75ntr/S100B" "p75ntr/IBA1" "p75ntr/CNPase" "Bassoon/Synaptophysin" "Bassoon/COXIV" "IBA1/DAPI" "GFAP/DAPI" "Parvalbumin (PV)" "Peri-Neuronal Network (PNN)" "PV/PNN"...
    "White Matter Stereological Estimates" "Tau-1" "Amyloid Beta" "Bcl2" "Bax" "MAP2" "VGlut1" "VGlut2" "CGRP" "5-HT" "Dopamine Beta Hydroxylase (DBH)" "DBH/NK1R" "NK1R" "GAD67" ...
    "Double Cortin" "TRPM3" "Cytochrome p450" "Phospho-eIF2a" "RANTES" "Phospho-NF-kB" "Celluar Prion Protein" "iNOS" "p-eNOS" "Fibronectin" "Laminin" ...
    "NF200" "C-Jun" "DBH/NeuN" "Triphenyltetrazolium Chloride (TTC)" "PSD-95" "Arc" "Piccolo" "Corticotrophin Releasing Hormone" "Beclin-1" "PINK1" "Cyt C" "mTOR" "CD31" "Arp2" "Calbindin D28k" ...
    "BrdU/NeuN" "Spinophilin" "Synaptophysin" "Tissue Atrophy - Motic DSAssistant" "GSTpi" "Propium Iodide" "cFos" "cFos/NeuN" "Neurofilaments"];

%reduced stains or tissue based paradigms with at least 1 effect size
NewStain_names = [Stain_names(1:3) Stain_names(8) Stain_names(12:13) Stain_names(16:17) Stain_names(19) Stain_names(38) Stain_names(42) Stain_names(47) Stain_names(69) Stain_names(77:82) Stain_names(91) Stain_names(108:111) Stain_names(114:115) Stain_names(120:121) Stain_names(123:124) Stain_names(138) Stain_names(159)];


%graph by species and model type, the height and weight with counter. so
%height or weight on x axis and the opposite on the y axis, and add a
%counter for the third axis
%need to split the axis for a line break
f1 = figure;
nlp_fig_prep(f1, "Portrait")
ax1 = axes;
nlp_axes_prep(ax1)
ylabel('Height of Drop in CM')
xlabel('Weight of Impactor in Grams','Position',[300 -12])
title('Height and Weight Parameters', 'Position',[300 305]);
text(300, 170, "Free Fall-Like WD Models and Rats", "Color", ORANGE)
text(300, 160, "Free Fall-Like WD Models and Mice", "Color", CYAN)
text(300, 150, "Fixed Surface WD Models and Rats", "Color", MAGENTA )
text(300, 140, "Fixed Surface WD Models and Mice", "Color", GREEN)
ylim([-2 210])
xlim([-2 600])
set(gca,'Position', [0.75 0.75 5.5 6.5])
% set(gca, 'Position', [0.75 0.75 6.5 7])
hold on
clear i
clear c
for i = 1:length(d)
    if d(i).ModelStat == 1 && d(i).Species == 1 %free fall and rat
        plot(d(i).weightinGrams(1:length(d(i).weightinGrams))+(randn(1)/50), d(i).heightinCM(1:length(d(i).heightinCM))+(randn(1)/50), 'color', ORANGE  , 'Marker','square','LineStyle','none' ,'LineWidth',3)
    elseif d(i).ModelStat == 0 && d(i).Species == 1 %marmarou and rat
        plot(d(i).weightinGrams(1:length(d(i).weightinGrams))+(randn(1)/50), d(i).heightinCM(1:length(d(i).heightinCM))+(randn(1)/50), 'color', MAGENTA, 'Marker','square','LineStyle','none' ,'LineWidth',3)
    elseif d(i).ModelStat == 1 && d(i).Species == 0 %free fall and mouse
        plot(d(i).weightinGrams(1:length(d(i).weightinGrams))+(randn(1)/50), d(i).heightinCM(1:length(d(i).heightinCM))+(randn(1)/50), 'color', CYAN  , 'Marker','square','LineStyle','none' ,'LineWidth',3)
    elseif d(i).ModelStat == 0 && d(i).Species == 0 %marmarou and mouse
        plot(d(i).weightinGrams(1:length(d(i).weightinGrams))+(randn(1)/50), d(i).heightinCM(1:length(d(i).heightinCM))+(randn(1)/50), 'color', GREEN  , 'Marker','square','LineStyle','none' ,'LineWidth',3)
    end
end
%keyboard
ax1.Clipping = "off";
plot([-12 12], [209 210], 'color', BLACK, 'LineStyle','-','LineWidth',2)


ax1 = axes;
nlp_axes_prep(ax1)
h = plot(d(110).weightinGrams(1), d(110).heightinCM(1), 'color', MAGENTA, 'Marker','square','LineStyle','none' ,'LineWidth',3 );
xlim([0 600]);
ylim([435 510]);
ax1.YAxis.FontSize = 12;
set(gca, 'Ytick', [440:20:500])
set(gca, 'Box', 'off')
set(gca, 'tickdir', 'out')
set(gca, 'Position', [0.75 7.325 5.5 1])
set(gca, 'XColor', 'none')
hold on
plot(d(114).weightinGrams(1), d(114).heightinCM(1), 'color', ORANGE, 'Marker','square','LineStyle','none' ,'LineWidth',3 )
ax1.Clipping = "off";
plot([-11 12], [434 436], 'color', BLACK, 'LineStyle','-','LineWidth',2)


%inset histogram for impactor weights
weightVal            = NaN(246,6);
weightValmouse       = NaN(246,6);
weightValrat         = NaN(246,6);
weightValmouseFREE   = NaN(246,6);
weightValratFREE     = NaN(246,6);
weightValmouseFIXED  = NaN(246,6);
weightValratFIXED    = NaN(246,6);

clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).weightinGrams)
        weightVal(i,c) = d(i).weightinGrams(c);

        if d(i).Species == 1
            weightValrat(i,c) = d(i).weightinGrams(c);
        elseif d(i).Species == 0
            weightValmouse(i,c) = d(i).weightinGrams(c);
            
        end

        if d(i).Species == 1 && d(i).ModelStat == 1
            weightValratFREE(i,c) = d(i).weightinGrams(c);
        elseif d(i).Species == 0 && d(i).ModelStat == 1
            weightValmouseFREE(i,c) = d(i).weightinGrams(c);
        elseif d(i).Species == 1 && d(i).ModelStat == 0
            weightValratFIXED(i,c) = d(i).weightinGrams(c);
        elseif d(i).Species == 0 && d(i).ModelStat == 0
            weightValmouseFIXED(i,c) = d(i).weightinGrams(c);
        end

    end
end
comboweightRat   = [weightValrat(:,1); weightValrat(:,2); weightValrat(:,3); weightValrat(:,4); weightValrat(:,5); weightValrat(:,6)];
comboweightMouse = [weightValmouse(:,1); weightValmouse(:,2); weightValmouse(:,3); weightValmouse(:,4); weightValmouse(:,5); weightValmouse(:,6)];


comboweightRatFREE    = [weightValratFREE(:,1)   ; weightValratFREE(:,2)   ; weightValratFREE(:,3)   ; weightValratFREE(:,4)   ; weightValratFREE(:,5)   ; weightValratFREE(:,6)];
comboweightMouseFREE  = [weightValmouseFREE(:,1) ; weightValmouseFREE(:,2) ; weightValmouseFREE(:,3) ; weightValmouseFREE(:,4) ; weightValmouseFREE(:,5) ; weightValmouseFREE(:,6)];
comboweightRatFIXED   = [weightValratFIXED(:,1)  ; weightValratFIXED(:,2)  ; weightValratFIXED(:,3)  ; weightValratFIXED(:,4)  ; weightValratFIXED(:,5)  ; weightValratFIXED(:,6)];
comboweightMouseFIXED = [weightValmouseFIXED(:,1); weightValmouseFIXED(:,2); weightValmouseFIXED(:,3); weightValmouseFIXED(:,4); weightValmouseFIXED(:,5); weightValmouseFIXED(:,6)];
%keyboard

ax1 = axes;
nlp_axes_prep(ax1)
h1 = nlp_hist_stair2(comboweightRatFREE, 0, 600, 7.5, 0);
h1.Color = ORANGE;
h1.LineWidth = 2;
text(200, 75, "Free Fall-Like WD and Rats Impactor Weight Frequencies", 'Color', ORANGE)
hold on
h2 = nlp_hist_stair2(comboweightMouseFREE, 0, 600, 7.5, 1);
h2.Color = CYAN;
h2.LineWidth = 2;
text(200, 65, "Free Fall-Like WD and Mice Impactor Weight Frequencies", 'Color', CYAN)
h3 = nlp_hist_stair2(comboweightRatFIXED, 0, 600, 7.5, 1.3);
h3.Color = MAGENTA;
h3.LineWidth = 2;
text(200, 55, "Fixed Surface WD and Rats Impactor Weight Frequencies", 'Color', MAGENTA)
h4 = nlp_hist_stair2(comboweightMouseFIXED, 0, 600, 7.5, 1.6);
h4.Color = GREEN;
h4.LineWidth = 2;
text(200, 45, "Fixed Surface WD and Mice Impactor Weight Frequencies", 'Color', GREEN)
set(gca, 'Position', [0.75 8.6 5.5 1.5]);
set(gca, 'XLim', [-2 600])
ylim([-2 80])
set(gca, "YTick", 0:20:80)
set(gca, 'TickDir','out')
%set(gca, 'xtick', '')
set(gca, 'Box', 'off')
ylabel('Frequency', 'FontSize', 9);
%keyboard

%inset histogram for fall heights of impactor
heightVal      = NaN(246,2);
heightValmouse = NaN(246,2);
heightValrat   = NaN(246,2);
heightValmouseFREE = NaN(246,2);
heightValratFREE   = NaN(246,2);
heightValmouseFIXED = NaN(246,2);
heightValratFIXED   = NaN(246,2);

clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).heightinCM)
        heightVal(i,c) = d(i).heightinCM(c);

        if d(i).Species == 1
            heightValrat(i,c) = d(i).heightinCM(c);
        elseif d(i).Species == 0
            heightValmouse(i,c) = d(i).heightinCM(c);
        end

        if d(i).Species == 1 && d(i).ModelStat == 1
            heightValratFREE(i,c) = d(i).heightinCM(c);
        elseif d(i).Species == 0 && d(i).ModelStat == 1
            heightValmouseFREE(i,c) = d(i).heightinCM(c);
        elseif d(i).Species == 1 && d(i).ModelStat == 0
            heightValratFIXED(i,c) = d(i).heightinCM(c);
        elseif d(i).Species == 0 && d(i).ModelStat == 0
            heightValmouseFIXED(i,c) = d(i).heightinCM(c);
        end

    end
end
comboheightRat = [heightValrat(:,1); heightValrat(:,2)];
comboheightMouse = [heightValmouse(:,1); heightValmouse(:,2)];

comboheightRatFREE    = [heightValratFREE(:,1)   ; heightValratFREE(:,2)];
comboheightMouseFREE  = [heightValmouseFREE(:,1) ; heightValmouseFREE(:,2)];
comboheightRatFIXED   = [heightValratFIXED(:,1)  ; heightValratFIXED(:,2)];
comboheightMouseFIXED = [heightValmouseFIXED(:,1); heightValmouseFIXED(:,2)];

ax1 = axes;
nlp_axes_prep(ax1)
h1 = nlp_hist_stair2(comboheightRatFREE, 0, 210, 2.6250, 0);
h1.Color = ORANGE;
h1.LineWidth = 2;
ht1 = text(200, 75, "Free Fall-Like WD and Rats Impactor Height Frequencies", 'Color', ORANGE);
ht1.Rotation = 270;
hold on
h2 = nlp_hist_stair2(comboheightMouseFREE, 0, 210, 2.6250, 1);
h2.Color = CYAN;
h2.LineWidth = 2;
ht2 = text(200, 65, "Free Fall-Like WD and Mice Impactor Height Frequencies", 'Color', CYAN);
ht2.Rotation = 270;
h3 = nlp_hist_stair2(comboheightRatFIXED, 0, 210, 2.6250, 0);
h3.Color = MAGENTA;
h3.LineWidth = 2;
ht3 = text(200, 55, "Fixed Surface WD and Rats Impactor Height Frequencies", 'Color', MAGENTA);
ht3.Rotation = 270;
hold on
h4 = nlp_hist_stair2(comboheightMouseFIXED, 0, 210, 2.6250, 1);
h4.Color = GREEN;
h4.LineWidth = 2;
ht4 = text(200, 45, "Fixed Surface WD and Mice Impactor Height Frequencies", 'Color', GREEN);
ht4.Rotation = 270;
%histogram(heightVal, 'numbins', 45, 'FaceColor', BLACK, 'EdgeColor', [1 1 1]);
set(gca, 'Position', [6.65, 0.75, 1.5, 6.5]);
set(gca, 'XLim', [0 210])
ylim([-3 80])
set(gca, "YTick", 0:20:80)
set(gca, 'YTickLabelRotation', 0)
set(gca, 'TickDir','out')
%set(gca, 'xtick', '')
set(gca, 'Box', 'off')
ylabel('Frequency', 'FontSize',9);
camroll(-270)
set(gca, 'xdir', "reverse")
set(gca, 'yaxislocation', "right")

ax1.Clipping = "off";
plot([210 211], [-5 5], 'color', BLACK, 'LineStyle','-','LineWidth',2)


%smaller inset
ax1 = axes;
nlp_axes_prep(ax1)
h5 = nlp_hist_stair2(comboheightRat(114), 435, 510, 5.9375,0);
h5.Color = ORANGE;
h5.LineWidth = 2;
ax1.TickLength = [0.05 0.035];
hold on
h6 = nlp_hist_stair2(0, 435, 510, 5.9375,1);
h6.Color = CYAN;
h6.LineWidth = 2;
h7 = nlp_hist_stair2(comboheightRat(110), 435, 510, 5.9375,1);
h7.Color = MAGENTA;
h7.LineWidth = 2;
ax1.TickLength = [0.05 0.035];
hold on
h8 = nlp_hist_stair2(0, 435, 510, 5.9375,1);
h8.Color = GREEN;
h8.LineWidth = 2;
ylim([-3 80])
set(gca, 'Position', [6.65, 7.325, 1.5, 1.0]);
set(gca, "YTick", 0:20:80)
set(gca, 'YTickLabelRotation', 0)
set(gca, 'TickDir','out')
%set(gca, 'xtick', '')
set(gca, 'Box', 'off')
ylabel('Frequency', 'FontSize',9);
camroll(-270)
set(gca, 'xdir', "reverse")
set(gca, 'yaxislocation', "left")
set(gca, 'YColor', 'none')
ax1.Clipping = "off";
plot([434 436],[-5 5], 'color', BLACK, 'LineStyle','-','LineWidth',2)
%%%
%keyboard



% some kind of graphs for demographic factors i.e., number of rats vs mice, number
% of male female both, prevalence of strains, anesthesia
%HIT COUNT - log scale
f2 = figure;
nlp_fig_prep(f2, "Portrait");
ax2 = axes;
nlp_axes_prep(ax2)
ylabel('Impact Number (Log Scale)')
set(gca, 'YScale', 'log')
set(gca, 'Yticklabel', {'1' '10' '100' '1000'})
set(gca, 'xtick', [1 2])
set(gca, "XTickLabel", {''})
set(gca, "Xticklabel", {"Free Fall-Like WD" "Fixed Surface WD"})
title("Impact Num")
text(1.5, 350, "Free Fall-Like Weight Drop (WD) Models and Rats", "Color", ORANGE)
text(1.5, 300, "Free Fall-Like Weight Drop (WD) Models and Mice", "Color", CYAN)
text(1.5, 250, "Fixed Surface Weight Drop (WD) Models and Rats", "Color", MAGENTA )
text(1.5, 200, "Fixed Surface Weight Drop (WD) Models and Mice", "Color", GREEN)
ylim([0.9 1000])
hold on
clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).hitCount)
        if d(i).ModelStat == 1 && d(i).Species == 1
            plot(1+(randn(1)/25), d(i).hitCount(c), 'color', ORANGE, 'marker', 's','LineWidth',3)
        elseif d(i).ModelStat == 1 && d(i).Species == 0
            plot(1+(randn(1)/25), d(i).hitCount(c), 'color', CYAN, 'marker', 's','LineWidth',3)
        elseif d(i).ModelStat == 0 && d(i).Species == 1
            plot(2+(randn(1)/25), d(i).hitCount(c), 'color', MAGENTA, 'Marker' ,'s','LineWidth',3)
        elseif d(i).ModelStat == 0 && d(i).Species == 0
            plot(2+(randn(1)/25), d(i).hitCount(c), 'color', GREEN, 'Marker' ,'s','LineWidth',3)
           
        end
    end
end
%hit count - not log scale
f3 = figure;
nlp_fig_prep(f3, "Portrait");
ax3 = axes;
nlp_axes_prep(ax3)
ylabel('Impact Number (Linear Scale)')
set(gca, 'YScale', 'linear')
set(gca, 'xtick', [1 2])
set(gca, "XTickLabel", {''})
set(gca, "Xticklabel", {"Free Fall-Like Weight Drop (WD)" "Fixed Surface Weight Drop (WD)"})
title("Impact Num")
text(1.5, 350, "Free Fall-Like WD and Rats", "Color", ORANGE)
text(1.5, 325, "Free Fall-Like WD and Mice", "Color", CYAN)
text(1.5, 300, "Fixed Surface WD and Rats", "Color", MAGENTA )
text(1.5, 275, "Fixed Surface WD and Mice", "Color", GREEN)
ylim([-2 400])
hold on
clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).hitCount)
        if d(i).ModelStat == 1 && d(i).Species == 1
            plot(1+(randn(1)/25), d(i).hitCount(c), 'color', ORANGE, 'marker', 's','LineWidth',3)
        elseif d(i).ModelStat == 1 && d(i).Species == 0
            plot(1+(randn(1)/25), d(i).hitCount(c), 'color', CYAN, 'marker', 's','LineWidth',3)
        elseif d(i).ModelStat == 0 && d(i).Species == 1
            plot(2+(randn(1)/25), d(i).hitCount(c), 'color', MAGENTA, 'Marker' ,'s','LineWidth',3)
        elseif d(i).ModelStat == 0 && d(i).Species == 0
            plot(2+(randn(1)/25), d(i).hitCount(c), 'color', GREEN, 'Marker' ,'s','LineWidth',3)
           
        end
    end
end

% f3 = figure;
% nlp_fig_prep(f3, "Portrait");
% ax3 = axes;
% nlp_axes_prep(ax3)
% ylabel('Most Conservative P-Values')
% set(gca, 'xtick', [1 2])
% set(gca, "XTickLabel", {''})
% set(gca, "Xticklabel", {"Free Fall-Like Weight Drop (WD)" "Fixed Surface Weight Drop (WD)"})
% title("Most Conservative P-Values")
% hold on
% for i = 1:length(d)
%     for c = 1:length(d(i).NHPSigLevel)
%         if d(i).ModelStat == 1
%             plot(1+(randn(1)/25), str2num(d(i).NHPSigLevel(c)), 'color', ORANGE, 'Marker', 's','LineWidth',3)
%             %plot(1, mean([d.rightTimeEffect], 'omitnan'), 'color', ORANGE, 'marker', 's', 'MarkerSize',10, 'linewidth', 2)
%         elseif d(i).ModelStat == 0
%             plot(2+(randn(1)/25), d(i).NHPSigLevel(c), 'color', MAGENTA, 'Marker' ,'o','LineWidth',3)
%             %plot(2, mean([d.rightTimeEffect], 'omitnan'), 'color', MAGENTA, 'marker', 'o', 'MarkerSize',10, 'linewidth', 2)
%         end
%     end
% end

%graph for distribution times of assessments





f4 = figure; %rough figure for getting an idea of dist
nlp_fig_prep(f4, "Portrait")
ax4 = axes;
nlp_axes_prep(ax4)
ylabel("Cohens d Effect Sizes")
title("Overall Effect Sizes by paradigm (each x-axis value is a behavioral assay or stain)")
text(25, 15, "Free Fall-Like WD Model and Rats", "Color", ORANGE)
text(25, 14, "Free Fall-Like WD Model and Mice", "Color", CYAN)
text(25, 13, "Fixed Surface WD Model and Rats", "Color", MAGENTA)
text(25, 12, "Fixed Surface WD Model and Mice", "Color", GREEN)
text(25, 5, "ignore me I'm just a sanity check")
hold on
clear i
clear c
for i = 1:length(d)
    for j = 1:length(d(i).task_or_stainCat)
        if d(i).ModelStat == 1 && d(i).Species == 1
            plot(d(i).task_or_stainCat(j), d(i).effectVal(j), 'color', ORANGE, 'marker', 'square')
        elseif d(i).ModelStat == 1 && d(i).Species == 0
            plot(d(i).task_or_stainCat(j), d(i).effectVal(j), 'color', CYAN, 'marker', 'square')

        elseif d(i).ModelStat == 0 && d(i).Species == 1
            plot(d(i).task_or_stainCat(j), d(i).effectVal(j), 'color', MAGENTA, 'marker', 'square')
        elseif d(i).ModelStat == 0 && d(i).Species == 0
            plot(d(i).task_or_stainCat(j), d(i).effectVal(j), 'color', GREEN, 'marker', 'square')
        end
    end
end
plot([0 300], [2 2], 'k-')

%%% under construction: dont delete

f5 = figure; %Behavior Paradigms
nlp_fig_prep(f5, "Portrait")
ax5 = axes;
nlp_axes_prep(ax5)
ylabel("Cohens d Effect Sizes")
title("Behavioral Effect Sizes")
text(18, 10, "Free Fall-Like WD Model and Rats", "Color", ORANGE)
text(18, 9.5, "Free Fall-Like WD Model and Mice", "Color", CYAN)
text(18, 9, "Fixed Surface WD Model and Rats", "Color", MAGENTA)
text(18, 8.5, "Fixed Surface WD Model and Mice", "Color", GREEN)
set(gca, 'xticklabels', NewBehavioral_names)
ax5.XAxis.FontSize = 11;
axis padded
ylim([-0.1 12])
xticks(1:31)
xtickangle(90)
hold on 
clear i
clear c
for i = 1:length(d)
    %keyboard
    for c = 1:length(d(i).effectVal)

        if d(i).ModelStat == 1 && d(i).Species == 1  && d(i).task_or_stainCat(c) == 1   
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2)

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 1 
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 1
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 1  
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 2
            plot(2+(randn(1)/30) , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  2 
            plot(2+(randn(1)/30) , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  2 
            plot(2+(randn(1)/30) , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  2 
            plot(2+(randn(1)/30) , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 3  
            plot(3+(randn(1)/30) , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 3 
            plot(3+(randn(1)/30) , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  3 
            plot(3+(randn(1)/30) , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  3 
            plot(3+(randn(1)/30) , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  4 
            plot(4+(randn(1)/30) , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  4 
            plot(4+(randn(1)/30) , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  4 
            plot(4+(randn(1)/30) , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  4 
            plot(4+(randn(1)/30) , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  64 
            plot(5 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  64 
            plot(5 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 ) 

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==  64 
            plot(5 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  64 
            plot(5 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 6
            plot(6 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 6  
            plot(6 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 6 
            plot(6 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 6  
            plot(6 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 7  
            plot(7 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 7  
            plot(7 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 7  
            plot(7 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 7  
            plot(7 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 9  
            plot(8 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 9 
            plot(8 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 9  
            plot(8 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 9  
            plot(8 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 88 
            plot(9 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 88
            plot(9 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 88
            plot(9 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 88
            plot(9 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 48
            plot(10 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 48
            plot(10 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 48
            plot(10 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 48
            plot(10 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 62
            plot(11 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 62
            plot(11 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 62
            plot(11 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 62
            plot(11 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 63
            plot(12 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 63
            plot(12 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 63
            plot(12 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 63
            plot(12 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 14
            plot(13 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 14 
            plot(13 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 14  
            plot(13 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 14  
            plot(13 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 15 
            plot(14+(randn(1)/30) , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 15  
            plot(14+(randn(1)/30) , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 15  
            plot(14+(randn(1)/30) , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 15  
            plot(14+(randn(1)/30) , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 16  
            plot(15 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 16  
            plot(15 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 16  
            plot(15 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 16  
            plot(15 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 18 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 22
            plot(16 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 18 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 22
            plot(16 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 18  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 22
            plot(16 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 18 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 22
            plot(16 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )



        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 94  
            plot(17 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 94 
            plot(17 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 94 
            plot(17 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 94 
            plot(17 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 29
            plot(18 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 29
            plot(18 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 29
            plot(18 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 29
            plot(18 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 30
            plot(19 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 30   
            plot(19 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 30  
            plot(19 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 30  
            plot(19 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 99 || d(i).task_or_stainCat(c) == 100 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 102
            plot(20 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 99 || d(i).task_or_stainCat(c) == 100 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 102
            plot(20 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 99 || d(i).task_or_stainCat(c) == 100 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 102
            plot(20 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 99 || d(i).task_or_stainCat(c) == 100 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 102
            plot(20 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 32
            plot(21 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==32
            plot(21 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==32
            plot(21 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==32
            plot(21 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )




        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 34 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 41 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 47 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 61 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 70
            plot(22 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 34 ||d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 41 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 47 ||d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 61 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 70
            plot(22 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 34 ||d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 41 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 47 ||d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 61 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 70
            plot(22 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 34 ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 41 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 47 ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 61 ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 70
            plot(22 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )



        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 38
            plot(23 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 38 
            plot(23 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 38  
            plot(23 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 38  
            plot(23 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )



        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 45
            plot(24 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 45 
            plot(24 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 45 
            plot(24 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 45  
            plot(24 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 46 
            plot(25 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 46 
            plot(25 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 46  
            plot(25 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 46  
            plot(25 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        % no sham anad tbi group comps(only fem) elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 54 
        %     plot(26 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
        % 
        % elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 54  
        %     plot(26 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
        % 
        % elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 54  
        %     plot(26 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
        % 
        % elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 54  
        %     plot(26 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  56 
            plot(26 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 56  
            plot(26 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 56  
            plot(26 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 56  
            plot(26 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )



        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 72 
            plot(27 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 72  
            plot(27 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 72  
            plot(27 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 72 
            plot(27 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )




        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  75
            plot(28, d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  75
            plot(28 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 75  
            plot(28 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 75  
            plot(28 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )



        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 82  
            plot(29 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 82  
            plot(29 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 82  
            plot(29 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 82  
            plot(29 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )




        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 90  
            plot(30 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 90  
            plot(30 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 90  
            plot(30 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 90  
            plot(30 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


   


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 107  
            plot(31 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 107  
            plot(31 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 107  
            plot(31 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 107  
            plot(31 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

            


       


        end
    end
end
%%%
f6 = figure; %Stain Paradigms %a possible solution is to graph 20 stains or tasks at a time
nlp_fig_prep(f6, "Portrait")
ax6 = axes;
nlp_axes_prep(ax6)
ylabel("Cohens d Effect Sizes")
title("Stain/Tissue Measure Effect Sizes")
text(1, 23, "Free Fall-Like WD Model and Rats", "Color", ORANGE)
text(1, 22, "Free Fall-Like WD Model and Mice", "Color", CYAN)
text(1, 21, "Fixed Surface WD Model and Rats", "Color", MAGENTA)
text(1, 20, "Fixed Surface WD Model and Mice", "Color", GREEN)
xticks(1:32)
xtickangle(90)
ax6.XAxis.FontSize = 11;
axis padded
ylim([-0.1 25])
set(gca, 'xticklabels', NewStain_names)
hold on
clear i
clear c
for i = 1:length(d)
    
    for c = 1:length(d(i).effectVal)

        if d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  110 
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 110  
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 110  
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 110  
            plot(1+(randn(1)/30) , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 111  
            plot(2 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 111  
            plot(2 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 111  
            plot(2 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 111  
            plot(2 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 112  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 257  || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 190  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 177 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 176  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 175
            plot(3 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 112  || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 257  || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 190  || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 177 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 176  || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 175
            plot(3 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 112  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 257  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 190  || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 177 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 176  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 175
            plot(3 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 112  || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 257  ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 190  || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 177 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 176  || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 175
            plot(3 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 117  
            plot(4 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 117  
            plot(4 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 117  
            plot(4 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 117  
            plot(4 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 122  
            plot(5 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  122 
            plot(5 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  122 
            plot(5 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  122 
            plot(5 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 123  
            plot(6 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 123  
            plot(6 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 123  
            plot(6 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 123  
            plot(6 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 126  
            plot(7 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 126  
            plot(7 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 126  
            plot(7 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 126  
            plot(7 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 127  
            plot(8 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 127  
            plot(8 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 127  
            plot(8 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 127  
            plot(8 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 129  
            plot(9 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 129  
            plot(9 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 129  
            plot(9 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 129 
            plot(9 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 149  
            plot(10 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 149 
            plot(10 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 149  
            plot(10 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 149  
            plot(10 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 153  
            plot(11 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 153 
            plot(11 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 153  
            plot(11 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 153  
            plot(11 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 158  || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 207 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 236  || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 256  
            plot(12 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 158  || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 207 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 236  || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 256
            plot(12 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 158  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 207 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 236  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 256
            plot(12 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 158  || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 207 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 236  || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 256
            plot(12 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 185 
            plot(13 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 185 
            plot(13 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 185 
            plot(13 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 185 
            plot(13 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 195 
            plot(14 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 195 
            plot(14 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 195 
            plot(14 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 195 
            plot(14 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 196  
            plot(15 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 196  
            plot(15 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 196  
            plot(15 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 196  
            plot(15 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 197 
            plot(16 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 197 
            plot(16 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 197 
            plot(16 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 197 
            plot(16 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  198 
            plot(17 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  198
            plot(17 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  198
            plot(17 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  198
            plot(17 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 199  
            plot(18 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 199  
            plot(18 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 199  
            plot(18 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 199  
            plot(18 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 200 
            plot(19 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 200 
            plot(19 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 200 
            plot(19 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 200 
            plot(19 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  212 
            plot(20 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  212 
            plot(20 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  212 
            plot(20 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  212 
            plot(20 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 229  
            plot(21 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 229
            plot(21 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 229
            plot(21 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 229
            plot(21 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 230  
            plot(22 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 230  
            plot(22 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 230  
            plot(22 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 230  
            plot(22 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 231  
            plot(23 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 231  
            plot(23 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 231  
            plot(23 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 231  
            plot(23 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  232 
            plot(24 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  232 
            plot(24 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  232 
            plot(24 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  232 
            plot(24 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 237 
            plot(25 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 237
            plot(25 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 237
            plot(25 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 237
            plot(25 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  238 
            plot(26 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  238 
            plot(26 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  238 
            plot(26 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  238 
            plot(26 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 243  
            plot(27 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 243  
            plot(27 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 243  
            plot(27 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 243  
            plot(27 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 244  
            plot(28 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 244  
            plot(28 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 244  
            plot(28 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 244  
            plot(28 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 246  
            plot(29 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 246  
            plot(29 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 246  
            plot(29 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 246  
            plot(29 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 247  
            plot(30 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 247  
            plot(30 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 247  
            plot(30 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 247  
            plot(30 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 264  
            plot(31 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 264
            plot(31 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 264
            plot(31 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 264
            plot(31 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
        

        elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 279   || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 233   || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 203 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 191   || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 168   || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 169   || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 202   || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 148   || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 121 
            plot(32 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 279   || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 233   || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 203 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 191   || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 168   || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 169   || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 202   || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 148   || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 121 
            plot(32 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 279   || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 233   || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 203 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 191   || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 168   || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 169   || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 202   || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 148   || d(i).ModelStat ==0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 121 
            plot(32 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )

        elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 279   || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 233   || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 203 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 191   || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 168   || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 169   || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 202   || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 148   || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 121 
            plot(32 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )


        end
    end
end




%%%
%effect sizes for righting time
rt    = [NaN(246, 8)];
rtFF  = [NaN(246, 8)]; %free fall
rtFS  = [NaN(246, 8)]; %fixed surface
rtRFF = NaN(246, 8);
rtMFF = NaN(246, 8);
rtRFS = NaN(246, 8);
rtMFS = NaN(246, 8);
clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).rightTimeEffect)
        rt(i,c) = d(i).rightTimeEffect(c);
        if d(i).ModelStat == 1
            rtFF(i,c) = d(i).rightTimeEffect(c);
        elseif d(i).ModelStat == 0
            rtFS(i,c) = d(i).rightTimeEffect(c);
        end
    end
end
rtFFMean = mean(rtFF, 2, 'omitnan');
rtFSMean = mean(rtFS, 2, 'omitnan');
rtFFMeanMean = mean(rtFFMean, 'omitnan');
rtFSMeanMean = mean(rtFSMean, 'omitnan');
rtFFSTD = std(rtFFMean, 'omitnan');
rtFSSTD = std(rtFSMean, 'omitnan');
[LrtFFRange UrtFFRange] = bounds(rtFFMean);
[LrtFSRange UrtFSRange] = bounds(rtFSMean);


clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).rightTimeEffect)
        rt(i,c) = d(i).rightTimeEffect(c);
        if d(i).ModelStat == 1 && d(i).Species == 1
            rtRFF(i,c) = d(i).rightTimeEffect(c);
        elseif d(i).ModelStat == 1 && d(i).Species == 0
            rtMFF(i,c) = d(i).rightTimeEffect(c);
        elseif d(i).ModelStat == 0 && d(i).Species == 1
            rtRFS(i,c) = d(i).rightTimeEffect(c);
        elseif d(i).ModelStat == 0 && d(i).Species == 0
            rtMFS(i,c) = d(i).rightTimeEffect(c);
        end
    end
end
rtRFFMean = mean(rtRFF, 2, 'omitnan');
rtMFFMean = mean(rtMFF, 2, 'omitnan');
rtRFSMean = mean(rtRFS, 2, 'omitnan');
rtMFSMean = mean(rtMFS, 2, 'omitnan');
rtRFFMeanMean = mean(rtRFFMean, 'omitnan');
rtMFFMeanMean = mean(rtMFFMean, 'omitnan');
rtRFSMeanMean = mean(rtRFSMean, 'omitnan');
rtMFSMeanMean = mean(rtMFSMean, 'omitnan');
rtRFFSTD = std(rtRFFMean, 'omitnan');
rtMFFSTD = std(rtMFFMean, 'omitnan');
rtRFSSTD = std(rtRFSMean, 'omitnan');
rtMFSSTD = std(rtMFSMean, 'omitnan');
[LrtRFFRange UrtRFFRange] = bounds(rtRFFMean);
[LrtMFFRange UrtMFFRange] = bounds(rtMFFMean);
[LrtRFSRange UrtRFSRange] = bounds(rtRFSMean);
[LrtMFSRange UrtMFSRange] = bounds(rtMFSMean);




f7 = figure;
nlp_fig_prep(f7, "Portrait");
ax7 = axes;
nlp_axes_prep(ax7)
ylabel('Cohens d Effect Size')
set(gca, 'xtick', [1 2 3 4])
set(gca, "XTickLabel", {''})
set(gca, "Xticklabel", {"Rat Free Fall-Like Models" "Mouse Free Fall-Like Models " "Rat Fixed Surface Models" "Mouse Fixed Surface Models"})
title("Righting Time")
% text(1.25, 5, "Free Fall-Like Weight Drop (WD) and Rat", "Color", ORANGE)
% text(1.25, 4.75, "Free Fall-Like Weight Drop (WD) and Mice", "Color", CYAN)
% text(1.25, 4.5, "Fixed Surface Weight Drop (WD) and Rat", "Color", MAGENTA )
% text(1.25, 4.25, "Fixed Surface Weight Drop (WD) and Mice", "Color", GREEN)
ylim([-0.05 6])
hold on
clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).rightTimeEffect)
        if d(i).ModelStat == 1 && d(i).Species ==1
            plot(1+(randn(1)/25), d(i).rightTimeEffect(c), 'color', ORANGE, 'marker', 's','LineWidth',3)
            plot(1, rtRFFMeanMean, 'color', BLACK, 'marker', 'square', 'LineWidth',3, 'markersize', 8)
            %plot(1, rtFFMeanMean, 'color', BLACK, 'marker', 'square', 'LineWidth',3, 'markersize', 8)

        elseif d(i).ModelStat == 1 && d(i).Species ==0
            plot(2+(randn(1)/25), d(i).rightTimeEffect(c), 'color', CYAN, 'marker', 's','LineWidth',3)
            plot(2, rtMFFMeanMean, 'color', BLACK, 'marker', 'square', 'LineWidth',3, 'markersize', 8)

        elseif d(i).ModelStat == 0 && d(i).Species == 1
            plot(3+(randn(1)/25), d(i).rightTimeEffect(c), 'color', MAGENTA, 'Marker' ,'s','LineWidth',3)
            plot(3, rtRFSMeanMean, 'color', BLACK, 'marker', 'square', 'LineWidth',3, 'markersize', 8)
            %plot(2, rtFSMeanMean, 'color', BLACK, 'marker', 's','LineWidth',3,  'markersize', 8)

        elseif d(i).ModelStat == 0 && d(i).Species == 0
            plot(4+(randn(1)/25), d(i).rightTimeEffect(c), 'color', GREEN, 'Marker' ,'s','LineWidth',3)
            plot(4, rtMFSMeanMean, 'color', BLACK, 'marker', 'square', 'LineWidth',3, 'markersize', 8)
        end
    end
end




TPfreqFFR = NaN(246, 84);

TPfreqFFM = NaN(246, 84);

TPfreqFSR = NaN(246, 84);

TPfreqFSM = NaN(246, 84);

for i = 1:length(d)
    for c = 1:length(d(i).ParsedTPSub)
        if d(i).ModelStat == 1 && d(i).Species == 1 && d(i).ParsedTPSub(c) > 0
            TPfreqFFR(i,c) = d(i).ParsedTPSub(c);

        elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).ParsedTPSub(c) > 0
            TPfreqFFM(i,c) = d(i).ParsedTPSub(c);

        elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).ParsedTPSub(c) > 0
            TPfreqFSR(i,c) = d(i).ParsedTPSub(c);

        elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).ParsedTPSub(c) > 0
            TPfreqFSM(i,c) = d(i).ParsedTPSub(c);
        end
    end
end

New_TPfreqFFR = [];
New_TPfreqFFM = [];
New_TPfreqFSR = [];
New_TPfreqFSM = [];
clear i
for i = 1:size(TPfreqFFR,2)
New_TPfreqFFR = [New_TPfreqFFR; TPfreqFFR(:,i)];
end

for i = 1:size(TPfreqFFM,2)
New_TPfreqFFM = [New_TPfreqFFM; TPfreqFFM(:,i)];
end

for i = 1:size(TPfreqFSR,2)
New_TPfreqFSR = [New_TPfreqFSR; TPfreqFSR(:,i)];
end

for i = 1:size(TPfreqFSM,2)
New_TPfreqFSM = [New_TPfreqFSM; TPfreqFSM(:,i)];
end



f8 = figure;
nlp_fig_prep(f8, "Portrait");
ax8 = axes;
nlp_axes_prep(ax8)
ylabel('Frequency of Timepoints')
xlabel('Timepoints Linear Scale (Days)')
title("Post-Injury Assessment Timepoints")
text(200, 85, "Free Fall-Like WD Models and Rats", "Color", ORANGE)
text(200, 80, "Free Fall-Like WD Models and Mice", "Color", CYAN)
text(200, 75, "Fixed Surface WD Models and Rats", "Color", MAGENTA )
text(200, 70, "Fixed Surface WD Models and Mice", "Color", GREEN)
ylim([-2 300])
xlim([0 400])
hold on
clear i
clear c
h1 = nlp_hist_stair2(New_TPfreqFFR, 0, 400, 7.5, 0);
h1.Color = ORANGE;
h1.LineWidth = 2;

h2 = nlp_hist_stair2(New_TPfreqFFM, 0, 400, 7.5, 1);
h2.Color = CYAN;
h2.LineWidth = 2;

h3 = nlp_hist_stair2(New_TPfreqFSR, 0, 400, 7.5, 2);
h3.Color = MAGENTA;
h3.LineWidth = 2;

h4 = nlp_hist_stair2(New_TPfreqFSM, 0, 400, 7.5, 3);
h4.Color = GREEN;
h4.LineWidth = 2;


f9 = figure;
nlp_fig_prep(f9, "Portrait");
ax9 = axes;
nlp_axes_prep(ax9)
ylabel('Frequency of Timepoints')
xlabel('Timepoints Log Scale (Days)')
set(gca, "XScale", "log")
title("Post-Injury Assessment Timepoints")
text(20, 85, "Free Fall-Like WD Models and Rats", "Color", ORANGE)
text(20, 80, "Free Fall-Like WD Models and Mice", "Color", CYAN)
text(20, 75, "Fixed Surface WD Models and Rats", "Color", MAGENTA )
text(20, 70, "Fixed Surface WD Models and Mice", "Color", GREEN)
ylim([-2 300])
%xlim([-3 400])
hold on
clear i
clear c
h1 = nlp_hist_stair2(New_TPfreqFFR, 0, 400, 2.5, 0);
h1.Color = ORANGE;
h1.LineWidth = 2;

h2 = nlp_hist_stair2(New_TPfreqFFM, 0, 400, 2.5, 1);
h2.Color = CYAN;
h2.LineWidth = 2;

h3 = nlp_hist_stair2(New_TPfreqFSR, 0, 400, 2.5, 2);
h3.Color = MAGENTA;
h3.LineWidth = 2;

h4 = nlp_hist_stair2(New_TPfreqFSM, 0, 400, 2.5, 3);
h4.Color = GREEN;
h4.LineWidth = 2;


[xCum_SumFFR, yCum_SumFFR] = cumsum_dist(New_TPfreqFFR);
[xCum_SumFFM, yCum_SumFFM] = cumsum_dist(New_TPfreqFFM);
[xCum_SumFSR, yCum_SumFSR] = cumsum_dist(New_TPfreqFSR);
[xCum_SumFSM, yCum_SumFSM] = cumsum_dist(New_TPfreqFSM);

TPMeanRFF = mean(xCum_SumFFR);
TPMeanMFF = mean(xCum_SumFFM);
TPMeanRFS = mean(xCum_SumFSR);
TPMeanMFS = mean(xCum_SumFSM);

TPMedianRFF = median(xCum_SumFFR);
TPMedianMFF = median(xCum_SumFFM);
TPMedianRFS = median(xCum_SumFSR);
TPMedianMFS = median(xCum_SumFSM);

TPStandDevRFF = std(xCum_SumFFR);
TPStandDevMFF = std(xCum_SumFFM);
TPStandDevRFS = std(xCum_SumFSR);
TPStandDevMFS = std(xCum_SumFSM);

[LTPRangeRFF UTPRangeRFF] = bounds(xCum_SumFFR);
[LTPRangeMFF UTPRangeMFF] = bounds(xCum_SumFFM);
[LTPRangeRFS UTPRangeRFS] = bounds(xCum_SumFSR);
[LTPRangeMFS UTPRangeMFS] = bounds(xCum_SumFSM);


f10 = figure;
nlp_fig_prep(f10, "Portrait");
ax10 = axes;
nlp_axes_prep(ax10)
ylabel('Percentage of Publications Completed')
xlabel('Timepoints Log Scale (Days)')
set(gca, "XScale", "log")
title("Post-Injury Assessment Timepoints")
text(.001, .85, "Free Fall-Like WD Models and Rats", "Color", ORANGE)
text(.001, .80, "Free Fall-Like WD Models and Mice", "Color", CYAN)
text(.001, .75, "Fixed Surface WD Models and Rats", "Color", MAGENTA )
text(.001, .70, "Fixed Surface WD Models and Mice", "Color", GREEN)
%ylim([-2 300])
%xlim([-3 400])
ylim([0 1.01])
set(gca, 'xticklabel', {'0.0001' '0.001' '0.01' '0.1' '1' '10' '100' '1000'})
hold on
plot(xCum_SumFFR, yCum_SumFFR, 'color', ORANGE, 'linewidth', 2)
plot(xCum_SumFFM, yCum_SumFFM, 'color', CYAN  , 'linewidth', 2)
plot(xCum_SumFSR, yCum_SumFSR, 'color', MAGENTA, 'linewidth', 2)
plot(xCum_SumFSM, yCum_SumFSM, 'color', GREEN, 'linewidth', 2)


f11 = figure;
nlp_fig_prep(f11, "Portrait");
ax11 = axes;
nlp_axes_prep(ax11)
ylabel('Percentage of Publications Completed')
xlabel('Timepoints Linear Scale (Days)')
set(gca, "XScale", "linear")
title("Post-Injury Assessment Timepoints")
text(175, .85, "Free Fall-Like WD Models and Rats", "Color", ORANGE)
text(175, .80, "Free Fall-Like WD Models and Mice", "Color", CYAN)
text(175, .75, "Fixed Surface WD Models and Rats", "Color", MAGENTA )
text(175, .70, "Fixed Surface WD Models and Mice", "Color", GREEN)
%ylim([-2 300])
ylim([0 1.01])
xlim([-3 400])
hold on
plot(xCum_SumFFR, yCum_SumFFR, 'color', ORANGE,  'linewidth', 2)
plot(xCum_SumFFM, yCum_SumFFM, 'color', CYAN  ,  'linewidth', 2)
plot(xCum_SumFSR, yCum_SumFSR, 'color', MAGENTA, 'linewidth', 2)
plot(xCum_SumFSM, yCum_SumFSM, 'color', GREEN,   'linewidth', 2)




%kinetic energy and newtons calculation based on mychasiuk equations from
%mychasiuk et al 2016 the direction of the association and rotational
%forces associated with mild traumatic brain injury in rodents effect
%behavioral and molecular outcomes
% kinetic energy (KE)  = mass (kg) * g (gravitational acceleration) * h (height
% in meters) <-- maybe this should be a different value.
% Force = KE/ D (d = distance in which weight came to a stop)
%
% 
%

KineticEner   = NaN(246, 6);
ForceWithStop = NaN(246, 6);
Newtons       = NaN(246, 6);

KineticEnerRatFF    = NaN(246, 6);
ForceWithStopRatFF  = NaN(246, 6);
NewtonsRatFF        = NaN(246, 6);
KineticEnerMiceFF   = NaN(246, 6);
ForceWithStopMiceFF = NaN(246, 6);
NewtonsMiceFF       = NaN(246, 6);
KineticEnerRatFS    = NaN(246, 6);
ForceWithStopRatFS  = NaN(246, 6);
NewtonsRatFS        = NaN(246, 6);
KineticEnerMiceFS   = NaN(246, 6);
ForceWithStopMiceFS = NaN(246, 6);
NewtonsMiceFS       = NaN(246, 6);
clear i 
clear c
for i = 1:length(d)
    d(i).KineticEner   =  (d(i).weightinGrams./1000).*(9.81).*(d(i).heightinCM./100);
    d(i).ForceWithStop =  d(i).KineticEner;
    d(i).Newtons       =  d(i).weightinGrams.*9.81;
end
clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).KineticEner)
        KineticEner(i,c)   = d(i).KineticEner(c);
        ForceWithStop(i,c) = d(i).ForceWithStop(c);
    %    Newtons(i,c)       = d(i).Newtons(c);
    end
end

clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).Newtons)
        Newtons(i,c) = d(i).Newtons(c);
    end
end

clear i 
clear c
for i = 1:length(d)
    for c = 1:length(d(i).KineticEner)

        if d(i).ModelStat == 1 && d(i).Species == 1
            KineticEnerRatFF(i,c)   = d(i).KineticEner(c);
            ForceWithStopRatFF(i,c) = d(i).ForceWithStop(c);
        %    NewtonsRatFF(i,c)       = d(i).Newtons(c);
        elseif d(i).ModelStat == 1 && d(i).Species == 0
            KineticEnerMiceFF(i,c)   = d(i).KineticEner(c);
            ForceWithStopMiceFF(i,c) = d(i).ForceWithStop(c);
       %     NewtonsMiceFF(i,c)       = d(i).Newtons(c);
        elseif d(i).ModelStat == 0 && d(i).Species == 1
            KineticEnerRatFS(i,c)   = d(i).KineticEner(c);
            ForceWithStopRatFS(i,c) = d(i).ForceWithStop(c);
      %      NewtonsRatFS(i,c)       = d(i).Newtons(c);
        elseif d(i).ModelStat == 0 && d(i).Species == 0
            KineticEnerMiceFS(i,c)   = d(i).KineticEner(c);
            ForceWithStopMiceFS(i,c) = d(i).ForceWithStop(c);
     %       NewtonsMiceFS(i,c)       = d(i).Newtons(c);
        end
    end
end

clear i
clear c
for i = 1:length(d)
    for c = 1:length(d(i).Newtons)
        if d(i).ModelStat == 1 && d(i).Species == 1
            NewtonsRatFF(i,c)       = d(i).Newtons(c);

        elseif d(i).ModelStat == 1 && d(i).Species == 0
            NewtonsMiceFF(i,c)      = d(i).Newtons(c);

        elseif d(i).ModelStat == 0 && d(i).Species == 1
            NewtonsRatFS(i,c)       = d(i).Newtons(c);

        elseif d(i).ModelStat == 0 && d(i).Species == 0
            NewtonsMiceFS(i,c)      = d(i).Newtons(c);
        end
    end
end

COMBOKineticEnerRatFF     = [KineticEnerRatFF(:,1); KineticEnerRatFF(:,2); KineticEnerRatFF(:,3); KineticEnerRatFF(:,4); KineticEnerRatFF(:,5); KineticEnerRatFF(:,6)];
COMBOForceWithStopRatFF   = [ForceWithStopRatFF(:,1); ForceWithStopRatFF(:,2); ForceWithStopRatFF(:,3); ForceWithStopRatFF(:,4); ForceWithStopRatFF(:,5); ForceWithStopRatFF(:,6)];
COMBONewtonsRatFF         = [NewtonsRatFF(:,1) ; NewtonsRatFF(:,2) ; NewtonsRatFF(:,3) ; NewtonsRatFF(:,4) ; NewtonsRatFF(:,5) ; NewtonsRatFF(:,6) ];

COMBOKineticEnerMiceFF    = [KineticEnerMiceFF(:,1); KineticEnerMiceFF(:,2); KineticEnerMiceFF(:,3); KineticEnerMiceFF(:,4); KineticEnerMiceFF(:,5); KineticEnerMiceFF(:,6)];
COMBOForceWithStopMiceFF  = [ForceWithStopMiceFF(:,1); ForceWithStopMiceFF(:,2); ForceWithStopMiceFF(:,3); ForceWithStopMiceFF(:,4); ForceWithStopMiceFF(:,5); ForceWithStopMiceFF(:,6)];
COMBONewtonsMiceFF        = [NewtonsMiceFF(:,1); NewtonsMiceFF(:,2); NewtonsMiceFF(:,3); NewtonsMiceFF(:,4); NewtonsMiceFF(:,5); NewtonsMiceFF(:,6)];

COMBOKineticEnerRatFS     = [KineticEnerRatFS(:,1); KineticEnerRatFS(:,2); KineticEnerRatFS(:,3); KineticEnerRatFS(:,4); KineticEnerRatFS(:,5); KineticEnerRatFS(:,6)];
COMBOForceWithStopRatFS   = [ForceWithStopRatFS(:,1); ForceWithStopRatFS(:,2); ForceWithStopRatFS(:,3); ForceWithStopRatFS(:,4); ForceWithStopRatFS(:,5); ForceWithStopRatFS(:,6)];
COMBONewtonsRatFS         = [NewtonsRatFS(:,1); NewtonsRatFS(:,2); NewtonsRatFS(:,3);  NewtonsRatFS(:,4); NewtonsRatFS(:,5); NewtonsRatFS(:,6)];

COMBOKineticEnerMiceFS    = [KineticEnerMiceFS(:,1); KineticEnerMiceFS(:,2); KineticEnerMiceFS(:,3); KineticEnerMiceFS(:,4); KineticEnerMiceFS(:,5); KineticEnerMiceFS(:,6)];
COMBOForceWithStopMiceFS  = [ForceWithStopMiceFS(:,1); ForceWithStopMiceFS(:,2); ForceWithStopMiceFS(:,3); ForceWithStopMiceFS(:,4); ForceWithStopMiceFS(:,5); ForceWithStopMiceFS(:,6)];
COMBONewtonsMiceFS        = [NewtonsMiceFS(:,1); NewtonsMiceFS(:,2); NewtonsMiceFS(:,3); NewtonsMiceFS(:,4); NewtonsMiceFS(:,5); NewtonsMiceFS(:,6)];

f12 = figure;
nlp_fig_prep(f12, "Portrait")
a12 = axes;
nlp_axes_prep(a12)
xlim([0 7])
ylim([-0.25 60])
title("Kinetic Energy")
xlabel("Joules")
ylabel("Frequency")
text(4, 55, "Free Fall-Like WD Models and Rats", "Color", ORANGE)
text(4, 50, "Free Fall-Like WD Models and Mice", "Color", CYAN)
text(4, 45, "Fixed Surface WD Models and Rats", "Color", MAGENTA )
text(4, 40, "Fixed Surface WD Models and Mice", "Color", GREEN)
hold on
h1 = nlp_hist_stair2(COMBOKineticEnerRatFF, 0, 7, .1, 0);
h1.Color = ORANGE;
h1.LineWidth = 2;
h2 = nlp_hist_stair2(COMBOKineticEnerMiceFF, 0, 7, .1, 0.01);
h2.Color = CYAN;
h2.LineWidth = 2;
h3 = nlp_hist_stair2(COMBOKineticEnerRatFS, 0, 7, .1, 0.001);
h3.Color = MAGENTA;
h3.LineWidth = 2;
h4 = nlp_hist_stair2(COMBOKineticEnerMiceFS, 0, 7, .1, 0.0001);
h4.Color = GREEN;
h4.LineWidth = 2;

