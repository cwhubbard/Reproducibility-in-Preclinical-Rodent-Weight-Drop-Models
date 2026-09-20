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
% % OLD BUT KEEEP FOR REFERENCING HOW MANY PARADIGMS HAD NO EFFECT SIZES
% f7 = figure;  %Behavior Paradigms
% nlp_fig_prep(f7, "Portrait")
% ax7 = axes;
% nlp_axes_prep(ax7)
% ylabel("Cohens d Effect Sizes")
% title("Behavioral Effect Sizes")
% text(25, 11, "Free Fall-Like Weight Drop (WD) Model and Rats", "Color", ORANGE)
% text(25, 10, "Free Fall-Like Weight Drop (WD) Model and Mice", "Color", CYAN)
% text(25, 9, "Fixed Surface Weight Drop (WD) Model and Rats", "Color", MAGENTA)
% text(25, 8, "Fixed Surface Weight Drop (WD) Model and Mice", "Color", GREEN)
% set(gca, 'xticklabels', Behavioral_names)
% ax7.XAxis.FontSize = 6;
% axis padded
% ylim([0 12])
% xticks(1:83)
% hold on 
% clear i
% clear c
% for i = 1:length(d)
% 
%     for c = 1:length(d(i).effectVal)
% 
%         if d(i).ModelStat == 1 && d(i).Species == 1  && d(i).task_or_stainCat(c) == 1   
%             plot(1 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 1 
%             plot(1 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 1
%             plot(1 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 1  
%             plot(1 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 2
%             plot(2 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  2 
%             plot(2 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  2 
%             plot(2 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  2 
%             plot(2 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 3  
%             plot(3 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 3 
%             plot(3 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  3 
%             plot(3 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  3 
%             plot(3 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  4 
%             plot(4 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  4 
%             plot(4 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  4 
%             plot(4 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  4 
%             plot(4 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==  64 
%             plot(5 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  64 
%             plot(5 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  64 
%             plot(5 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  5 || d(i).ModelStat == 0 && d(i).Species == 0  &&  d(i).task_or_stainCat(c) ==  64 
%             plot(5 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 6
%             plot(6 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 6  
%             plot(6 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 6 
%             plot(6 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 6  
%             plot(6 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 7  
%             plot(7 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 7  
%             plot(7 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 7  
%             plot(7 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 7  
%             plot(7 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 8  
%             plot(8 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 8  
%             plot(8 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 8  
%             plot(8 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 8  
%             plot(8 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 9  
%             plot(9 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 9 
%             plot(9 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 9  
%             plot(9 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 9  
%             plot(9 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 88 
%             plot(10 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 88
%             plot(10 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 88
%             plot(10 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 10 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 88
%             plot(10 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 48
%             plot(11 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 48
%             plot(11 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 48
%             plot(11 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 11 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 48
%             plot(11 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 62
%             plot(12 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 62
%             plot(12 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 62
%             plot(12 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 12 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 62
%             plot(12 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 63
%             plot(13 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 63
%             plot(13 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 63
%             plot(13 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 13 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 63
%             plot(13 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 14
%             plot(14 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 14 
%             plot(14 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 14  
%             plot(14 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 14  
%             plot(14 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 15 
%             plot(15 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 15  
%             plot(15 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 15  
%             plot(15 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 15  
%             plot(15 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 16  
%             plot(16 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 16  
%             plot(16 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 16  
%             plot(16 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 16  
%             plot(16 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 18 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 22
%             plot(17 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 18 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 22
%             plot(17 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 18 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 22
%             plot(17 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 17 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 18 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 22
%             plot(17 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 19 
%             plot(18 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 19 
%             plot(18 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 19  
%             plot(18 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 19  
%             plot(18 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 20 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 65 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 71 
%             plot(19 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 20 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 65 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 71
%             plot(19 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 20 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 65 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 71
%             plot(19 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 20 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 65 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 71
%             plot(19 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 21  
%             plot(20 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 21  
%             plot(20 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 21
%             plot(20 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 21  
%             plot(20 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 94  
%             plot(21 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 94 
%             plot(21 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 94 
%             plot(21 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 23 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 94 
%             plot(21 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  24 
%             plot(22 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  24 
%             plot(22 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  24
%             plot(22 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  24 
%             plot(22 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  25 
%             plot(23 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  25 
%             plot(23 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  25
%             plot(23 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  25
%             plot(23 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  26
%             plot(24 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 26  
%             plot(24 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 26
%             plot(24 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 26
%             plot(24 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 27
%             plot(25 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 27
%             plot(25 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 27  
%             plot(25 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  27
%             plot(25 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 28 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 96  || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 95
%             plot(26 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 28 ||  d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 96  ||d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 95
%             plot(26 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 28 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 96  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 95
%             plot(26 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 28 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 96  || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 95
%             plot(26 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 29
%             plot(27 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 29
%             plot(27 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 29
%             plot(27 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 29
%             plot(27 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 30
%             plot(28 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 30   
%             plot(28 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 30  
%             plot(28 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 30  
%             plot(28 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 99 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 100 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 102
%             plot(29 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 99 ||d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 100 ||  d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 102
%             plot(29 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 99 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 100 || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 102
%             plot(29 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 31 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 98  || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 99 ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 100 || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 102
%             plot(29 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 32
%             plot(30 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==32
%             plot(30 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==32
%             plot(30 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==32
%             plot(30 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  33
%             plot(31, d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 33 
%             plot(31 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 33 
%             plot(31 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 33  
%             plot(31 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 34 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 41 ||d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 47 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 61 || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 70
%             plot(32 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 34 ||d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 41 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 47 ||d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 61 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 70
%             plot(32 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 34 ||d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 41 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 47 ||d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 61 || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 70
%             plot(32 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 34 ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 41 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 47 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 61 || d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 70
%             plot(32 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 35
%             plot(33 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 35
%             plot(33 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 35  
%             plot(33 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 35  
%             plot(33 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 36  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 67
%             plot(34 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 36  || d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 67
%             plot(34 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 36  || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 67
%             plot(34 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 36  || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 67
%             plot(34 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==  37 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 40
%             plot(35 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  37 ||d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 40
%             plot(35 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==  37 ||d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 40
%             plot(35 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  37 ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 40
%             plot(35 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 38
%             plot(36 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 38 
%             plot(36 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 38  
%             plot(36 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 38  
%             plot(36 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 39  
%             plot(37 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 39
%             plot(37 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 39
%             plot(37 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 39
%             plot(37 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 42 
%             plot(38 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 42  
%             plot(38 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 42  
%             plot(38 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 42  
%             plot(38 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  43 || d(i).ModelStat == 1 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 44
%             plot(39 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  43 || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 44
%             plot(39 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  43 ||d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 44
%             plot(39 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  43 ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 44
%             plot(39 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 45
%             plot(40 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 45 
%             plot(40 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 45 
%             plot(40 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 45  
%             plot(40 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 46 
%             plot(41 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 46 
%             plot(41 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 46  
%             plot(41 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 46  
%             plot(41 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 49  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 50
%             plot(42 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 49  || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 50
%             plot(42 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 49  || d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 50
%             plot(42 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 49  || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 50
%             plot(42 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 51 
%             plot(43 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 51  
%             plot(43 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 51  
%             plot(43 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  51 
%             plot(43 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  52 
%             plot(44 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  52 
%             plot(44 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  52 
%             plot(44 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  52 
%             plot(44 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 53  
%             plot(45 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 53 
%             plot(45 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  53 
%             plot(45 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 53  
%             plot(45 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 54 
%             plot(46 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 54  
%             plot(46 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 54  
%             plot(46 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 54  
%             plot(46 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 55  
%             plot(47 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  55 
%             plot(47 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  55 
%             plot(47 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 55 
%             plot(47 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  56 
%             plot(48 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 56  
%             plot(48 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 56  
%             plot(48 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 56  
%             plot(48 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 57  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 89
%             plot(49 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 57  || d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 89
%             plot(49 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 57  || d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 89
%             plot(49 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 57  || d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 89
%             plot(49 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 58  
%             plot(50 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 58  
%             plot(50 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 58  
%             plot(50 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 58  
%             plot(50 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 59 
%             plot(51 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 59  
%             plot(51 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 59  
%             plot(51 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 59  
%             plot(51 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 60  
%             plot(52 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 60  
%             plot(52 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 60  
%             plot(52 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 60  
%             plot(52 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 66  
%             plot(53 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 66  
%             plot(53 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 66 
%             plot(53 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 66  
%             plot(53 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 68 
%             plot(54 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 68 
%             plot(54 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 68  
%             plot(54 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 68  
%             plot(54 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 69 
%             plot(55 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 69  
%             plot(55 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 69 
%             plot(55 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 69 
%             plot(55 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 72 
%             plot(56 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 72  
%             plot(56 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 72  
%             plot(56 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 72 
%             plot(56 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 73  
%             plot(57 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 73  
%             plot(57 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 73  
%             plot(57 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 73  
%             plot(57 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 74  
%             plot(58 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 74  
%             plot(58 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 74  
%             plot(58 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 74  
%             plot(58 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  75
%             plot(59, d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  75
%             plot(59 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 75  
%             plot(59 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 75  
%             plot(59 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 76  
%             plot(60 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 76  
%             plot(60 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 76  
%             plot(60 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 76  
%             plot(60 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 77  
%             plot(61 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 77 
%             plot(61 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 77  
%             plot(61 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 77  
%             plot(61 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 78  
%             plot(62 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 78  
%             plot(62 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 78  
%             plot(62 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 78  
%             plot(62 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  79 
%             plot(63 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  79 
%             plot(63 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  79
%             plot(63 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  79 
%             plot(63 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 80  
%             plot(64 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 80  
%             plot(64 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 80  
%             plot(64 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 80  
%             plot(64 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 81  
%             plot(65 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 81  
%             plot(65 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 81  
%             plot(65 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 81 
%             plot(65 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 82  
%             plot(66 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 82  
%             plot(66 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 82  
%             plot(66 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 82  
%             plot(66 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 83  
%             plot(67 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 83  
%             plot(67 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 83  
%             plot(67 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 83  
%             plot(67 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 84  || d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 106
%             plot(68 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 84  ||d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 106
%             plot(68 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 84  ||d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 106
%             plot(68 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 84  ||d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 106
%             plot(68 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 85  
%             plot(69 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 85  
%             plot(69 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 85  
%             plot(69 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 85
%             plot(69 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 86  
%             plot(70 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 86 
%             plot(70 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 86  
%             plot(70 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 86  
%             plot(70 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 87  
%             plot(71 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 87  
%             plot(71 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 87 
%             plot(71 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 87  
%             plot(71 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 90  
%             plot(72 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 90  
%             plot(72 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 90  
%             plot(72 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 90  
%             plot(72 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 91 
%             plot(73 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 91  
%             plot(73 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 91  
%             plot(73 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 91  
%             plot(73 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 92 
%             plot(74 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 92  
%             plot(74 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 92  
%             plot(74 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  92 
%             plot(74 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 93 
%             plot(75 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 93  
%             plot(75 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 93  
%             plot(75 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 93  
%             plot(75 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 97 
%             plot(76 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 97  
%             plot(76 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 97 
%             plot(76 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 97  
%             plot(76 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 101  
%             plot(77 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 101 
%             plot(77 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 101  
%             plot(77 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 101 
%             plot(77 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 103  
%             plot(78 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 103  
%             plot(78 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 103  
%             plot(78 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 103 
%             plot(78 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 104 
%             plot(79 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 104  
%             plot(79 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 104  
%             plot(79 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 104  
%             plot(79 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 105  
%             plot(80 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 105  
%             plot(80 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 105  
%             plot(80 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 105  
%             plot(80 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 107  
%             plot(81 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 107  
%             plot(81 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 107  
%             plot(81 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 107  
%             plot(81 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 108  
%             plot(82 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 108 
%             plot(82 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 108  
%             plot(82 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 108  
%             plot(82 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 109  
%             plot(83 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 109  
%             plot(83 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 109 
%             plot(83 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 109  
%             plot(83 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         end
%     end
% end

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



% OLD BUT KEEP TO REFERENCE HOW MANY STAINS HAD NO EFFECT SIZES
% f7 = figure; %Stain Paradigms %a possible solution is to graph 20 stains or tasks at a time
% nlp_fig_prep(f7, "Portrait")
% ax7 = axes;
% nlp_axes_prep(ax7)
% ylabel("Cohens d Effect Sizes")
% title("Stain/Tissue Effect Sizes")
% text(25, 22, "Free Fall-Like Weight Drop (WD) Model and Rats", "Color", ORANGE)
% text(25, 21, "Free Fall-Like Weight Drop (WD) Model and Mice", "Color", CYAN)
% text(25, 20, "Fixed Surface Weight Drop (WD) Model and Rats", "Color", MAGENTA)
% text(25, 19, "Fixed Surface Weight Drop (WD) Model and Mice", "Color", GREEN)
% xticks(1:159)
% ax7.XAxis.FontSize = 6;
% axis padded
% ylim([0 25])
% set(gca, 'xticklabels', Stain_names)
% hold on
% clear i
% clear c
% for i = 1:length(d)
% 
%     for c = 1:length(d(i).effectVal)
% 
%         if d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  110 
%             plot(1 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 110  
%             plot(1 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 110  
%             plot(1 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 110  
%             plot(1 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 111  
%             plot(2 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 111  
%             plot(2 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 111  
%             plot(2 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 111  
%             plot(2 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 112  || d(i).task_or_stainCat(c) == 257  || d(i).task_or_stainCat(c) == 190  || d(i).task_or_stainCat(c) == 177 || d(i).task_or_stainCat(c) == 176  || d(i).task_or_stainCat(c) == 175
%             plot(3 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 112  || d(i).task_or_stainCat(c) == 257  || d(i).task_or_stainCat(c) == 190  || d(i).task_or_stainCat(c) == 177 || d(i).task_or_stainCat(c) == 176  || d(i).task_or_stainCat(c) == 175
%             plot(3 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 112  || d(i).task_or_stainCat(c) == 257  || d(i).task_or_stainCat(c) == 190  || d(i).task_or_stainCat(c) == 177 || d(i).task_or_stainCat(c) == 176  || d(i).task_or_stainCat(c) == 175
%             plot(3 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 112  || d(i).task_or_stainCat(c) == 257  || d(i).task_or_stainCat(c) == 190  || d(i).task_or_stainCat(c) == 177 || d(i).task_or_stainCat(c) == 176  || d(i).task_or_stainCat(c) == 175
%             plot(3 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 113
%             plot(4 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 113  
%             plot(4 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 113  
%             plot(4 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 113  
%             plot(4 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 114  
%             plot(5 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 114  
%             plot(5 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 114
%             plot(5 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 114  
%             plot(5 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 115
%             plot(6 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 115 
%             plot(6 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 115
%             plot(6 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 115 
%             plot(6 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  116 
%             plot(7 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 116 
%             plot(7 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 116  
%             plot(7 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 116 
%             plot(7 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 117  
%             plot(8 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 117  
%             plot(8 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 117  
%             plot(8 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 117  
%             plot(8 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 118  
%             plot(9 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 118  
%             plot(9 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 118  
%             plot(9 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 118 
%             plot(9 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 119  
%             plot(10 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 119  
%             plot(10 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 119 
%             plot(10 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 119  
%             plot(10 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 120  
%             plot(11 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 120  
%             plot(11 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 120 
%             plot(11 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 120  
%             plot(11 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 122  
%             plot(12 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  122 
%             plot(12 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  122 
%             plot(12 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  122 
%             plot(12 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 123  
%             plot(13 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 123  
%             plot(13 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 123  
%             plot(13 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 123  
%             plot(13 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 124 || d(i).task_or_stainCat(c) == 253  
%             plot(14 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 124 || d(i).task_or_stainCat(c) == 253
%             plot(14 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 124 || d(i).task_or_stainCat(c) == 253  
%             plot(14 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 124 || d(i).task_or_stainCat(c) == 253  
%             plot(14 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 125 
%             plot(15 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 125  
%             plot(15 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 125  
%             plot(15 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 125  
%             plot(15 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 126  
%             plot(16 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 126  
%             plot(16 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 126  
%             plot(16 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 126  
%             plot(16 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 127  
%             plot(17 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 127  
%             plot(17 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 127  
%             plot(17 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 127  
%             plot(17 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 128  
%             plot(18 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 128  
%             plot(18 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 128 
%             plot(18 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 128 
%             plot(18 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 129  
%             plot(19 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 129  
%             plot(19 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 129  
%             plot(19 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 129 
%             plot(19 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 130 
%             plot(20 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 130  
%             plot(20 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 130 
%             plot(20 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 130 
%             plot(20 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 131  
%             plot(21 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 131  
%             plot(21 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 131  
%             plot(21 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 131 
%             plot(21 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 132  
%             plot(22 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 132  
%             plot(22 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 132  
%             plot(22 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 132  
%             plot(22 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 133 
%             plot(23 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 133  
%             plot(23 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 133  
%             plot(23 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 133  
%             plot(23 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 134  
%             plot(24 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 134 
%             plot(24 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 134  
%             plot(24 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 134  
%             plot(24 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 135   
%             plot(25 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 135  
%             plot(25 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 135  
%             plot(25 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 135  
%             plot(25 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 136  
%             plot(26 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 136  
%             plot(26 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 136  
%             plot(26 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 136  
%             plot(26 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 137  
%             plot(27 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 137 
%             plot(27 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 137  
%             plot(27 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 137  
%             plot(27 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 138  
%             plot(28 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 138 
%             plot(28 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 138  
%             plot(28 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 138  
%             plot(28 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  139 
%             plot(29 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 139  
%             plot(29 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 139  
%             plot(29 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 139 
%             plot(29 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 140  
%             plot(30 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 140  
%             plot(30 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 140  
%             plot(30 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 140  
%             plot(30 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 141  
%             plot(31, d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 141  
%             plot(31 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 141  
%             plot(31 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 141  
%             plot(31 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 142  
%             plot(32 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 142  
%             plot(32 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 142 
%             plot(32 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 142 
%             plot(32 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 143  
%             plot(33 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 143 
%             plot(33 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  143 
%             plot(33 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 143  
%             plot(33 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 144  
%             plot(34 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 144  
%             plot(34 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 144  
%             plot(34 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 144  
%             plot(34 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 145 
%             plot(35 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 145  
%             plot(35 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 145  
%             plot(35 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 145  
%             plot(35 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 146  
%             plot(36 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 146  
%             plot(36 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 146 
%             plot(36 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 146  
%             plot(36 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 147  
%             plot(37 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 147 
%             plot(37 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 147  
%             plot(37 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 147  
%             plot(37 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 149  
%             plot(38 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 149 
%             plot(38 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 149  
%             plot(38 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 149  
%             plot(38 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 150 
%             plot(39 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 150  
%             plot(39 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 150 
%             plot(39 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 150  
%             plot(39 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 151  
%             plot(40 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 151  
%             plot(40 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 151  
%             plot(40 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 151  
%             plot(40 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 152  
%             plot(41 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 152  
%             plot(41 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 152 
%             plot(41 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 152 
%             plot(41 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 153  
%             plot(42 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 153 
%             plot(42 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 153  
%             plot(42 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 153  
%             plot(42 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 154 
%             plot(43 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 154  
%             plot(43 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 154 
%             plot(43 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 154 
%             plot(43 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 155 
%             plot(44 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 155  
%             plot(44 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 155  
%             plot(44 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 155  
%             plot(44 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 156  
%             plot(45 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 156  
%             plot(45 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 156  
%             plot(45 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 156  
%             plot(45 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  157 
%             plot(46 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  157 
%             plot(46 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 157  
%             plot(46 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 157  
%             plot(46 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 158  || d(i).task_or_stainCat(c) == 207 || d(i).task_or_stainCat(c) == 236  || d(i).task_or_stainCat(c) == 256  
%             plot(47 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 158  || d(i).task_or_stainCat(c) == 207 || d(i).task_or_stainCat(c) == 236  || d(i).task_or_stainCat(c) == 256
%             plot(47 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 158  || d(i).task_or_stainCat(c) == 207 || d(i).task_or_stainCat(c) == 236  || d(i).task_or_stainCat(c) == 256
%             plot(47 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 158  || d(i).task_or_stainCat(c) == 207 || d(i).task_or_stainCat(c) == 236  || d(i).task_or_stainCat(c) == 256
%             plot(47 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  159
%             plot(48 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  159 
%             plot(48 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  159 
%             plot(48 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 159  
%             plot(48 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 160  
%             plot(49 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 160  
%             plot(49 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 160  
%             plot(49 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 160 
%             plot(49 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 161  
%             plot(50 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 161  
%             plot(50 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 161  
%             plot(50 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 161  
%             plot(50 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 162 
%             plot(51 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 162  
%             plot(51 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 162  
%             plot(51 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 162  
%             plot(51 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 163  
%             plot(52 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 163  
%             plot(52 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 163  
%             plot(52 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 163  
%             plot(52 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 164  
%             plot(53 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 164  
%             plot(53 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 164  
%             plot(53 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 164  
%             plot(53 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 165  
%             plot(54 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 165  
%             plot(54 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 165  
%             plot(54 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 165  
%             plot(54 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 166  
%             plot(55 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 166  
%             plot(55 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 166  
%             plot(55 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 166 
%             plot(55 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 167  
%             plot(56 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 167  
%             plot(56 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  167 
%             plot(56 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 167  
%             plot(56 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 170  
%             plot(57 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 170
%             plot(57 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 170
%             plot(57 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 170
%             plot(57 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 171 
%             plot(58 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 171 
%             plot(58 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 171 
%             plot(58 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 171 
%             plot(58 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 172 
%             plot(59, d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 172 
%             plot(59 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 172 
%             plot(59 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 172 
%             plot(59 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 173  
%             plot(60 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 173  
%             plot(60 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 173  
%             plot(60 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 173  
%             plot(60 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 174 
%             plot(61 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 174 
%             plot(61 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 174 
%             plot(61 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 174 
%             plot(61 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 178
%             plot(62 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 178
%             plot(62 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 178
%             plot(62 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 178
%             plot(62 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 179
%             plot(63 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 179
%             plot(63 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 179
%             plot(63 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 179
%             plot(63 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  180
%             plot(64 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  180
%             plot(64 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  180
%             plot(64 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  180
%             plot(64 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 181 
%             plot(65 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 181 
%             plot(65 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 181 
%             plot(65 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 181 
%             plot(65 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 182 
%             plot(66 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 182 
%             plot(66 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 182 
%             plot(66 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 182 
%             plot(66 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 183 
%             plot(67 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 183 
%             plot(67 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 183 
%             plot(67 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 183 
%             plot(67 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 184 
%             plot(68 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 184 
%             plot(68 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 184 
%             plot(68 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 184 
%             plot(68 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 185 
%             plot(69 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 185 
%             plot(69 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 185 
%             plot(69 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 185 
%             plot(69 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 186 
%             plot(70 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 186 
%             plot(70 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 186 
%             plot(70 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 186 
%             plot(70 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  187 
%             plot(71 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  187 
%             plot(71 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  187 
%             plot(71 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  187 
%             plot(71 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 188  
%             plot(72 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 188  
%             plot(72 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 188  
%             plot(72 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 188  
%             plot(72 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 189  
%             plot(73 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 189  
%             plot(73 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 189  
%             plot(73 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 189  
%             plot(73 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 192  
%             plot(74 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 192  
%             plot(74 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 192  
%             plot(74 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 192  
%             plot(74 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 193 
%             plot(75 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 193 
%             plot(75 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 193 
%             plot(75 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 193 
%             plot(75 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  194 
%             plot(76 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  194 
%             plot(76 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  194 
%             plot(76 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  194 
%             plot(76 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 195 
%             plot(77 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 195 
%             plot(77 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 195 
%             plot(77 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 195 
%             plot(77 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 196  
%             plot(78 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 196  
%             plot(78 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 196  
%             plot(78 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 196  
%             plot(78 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 197 
%             plot(79 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 197 
%             plot(79 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 197 
%             plot(79 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 197 
%             plot(79 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  198 
%             plot(80 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  198
%             plot(80 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  198
%             plot(80 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  198
%             plot(80 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 199  
%             plot(81 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 199  
%             plot(81 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 199  
%             plot(81 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 199  
%             plot(81 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 200 
%             plot(82 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 200 
%             plot(82 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 200 
%             plot(82 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 200 
%             plot(82 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 201  
%             plot(83 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 201  
%             plot(83 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 201  
%             plot(83 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 201  
%             plot(83 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 204  
%             plot(84 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 204
%             plot(84 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 204
%             plot(84 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 204
%             plot(84 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 205  
%             plot(85 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 205  
%             plot(85 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 205  
%             plot(85 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 205  
%             plot(85 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 206  
%             plot(86 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 206  
%             plot(86 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 206  
%             plot(86 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 206  
%             plot(86 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  208 
%             plot(87 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  208 
%             plot(87 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  208 
%             plot(87 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  208 
%             plot(87 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  209
%             plot(88 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  209
%             plot(88 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  209
%             plot(88 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  209
%             plot(88 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  210 
%             plot(89 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  210 
%             plot(89 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==  210 
%             plot(89 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  210 
%             plot(89 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 211  
%             plot(90 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 211  
%             plot(90 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 211  
%             plot(90 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 211  
%             plot(90 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  212 
%             plot(91 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  212 
%             plot(91 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  212 
%             plot(91 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  212 
%             plot(91 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 213  
%             plot(92 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 213
%             plot(92 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 213
%             plot(92 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 213
%             plot(92 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 214 
%             plot(93 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 214 
%             plot(93 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 214 
%             plot(93 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 214 
%             plot(93 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  215 
%             plot(94 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  215 
%             plot(94 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  215 
%             plot(94 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  215 
%             plot(94 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 216  
%             plot(95 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 216  
%             plot(95 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 216  
%             plot(95 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 216  
%             plot(95 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 217  
%             plot(96 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 217  
%             plot(96 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 217  
%             plot(96 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 217  
%             plot(96 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 218 
%             plot(97 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 218 
%             plot(97 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 218 
%             plot(97 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 218 
%             plot(97 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 219  
%             plot(98 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 219  
%             plot(98 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 219  
%             plot(98 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 219  
%             plot(98 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 220  
%             plot(99 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 220  
%             plot(99 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 220  
%             plot(99 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 220  
%             plot(99 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 221
%             plot(100 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 221
%             plot(100 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 221
%             plot(100 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 221
%             plot(100 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 222  
%             plot(101 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 222  
%             plot(101 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 222  
%             plot(101 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 222  
%             plot(101 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 223  
%             plot(102 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 223  
%             plot(102 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 223  
%             plot(102 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 223  
%             plot(102 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 224  
%             plot(103 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 224  
%             plot(103 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 224  
%             plot(103 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 224  
%             plot(103 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 225  
%             plot(104 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 225  
%             plot(104 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 225  
%             plot(104 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 225  
%             plot(104 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 226  
%             plot(105 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 226  
%             plot(105 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 226  
%             plot(105 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 226  
%             plot(105 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  227 
%             plot(106 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  227 
%             plot(106 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  227 
%             plot(106 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  227 
%             plot(106 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  228 
%             plot(107 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  228
%             plot(107 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  228
%             plot(107 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  228
%             plot(107 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 229  
%             plot(108 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 229
%             plot(108 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 229
%             plot(108 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 229
%             plot(108 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 230  
%             plot(109 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 230  
%             plot(109 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 230  
%             plot(109 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 230  
%             plot(109 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 231  
%             plot(110 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 231  
%             plot(110 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 231  
%             plot(110 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 231  
%             plot(110 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  232 
%             plot(111 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  232 
%             plot(111 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  232 
%             plot(111 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  232 
%             plot(111 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 234 
%             plot(112 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 234 
%             plot(112 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 234 
%             plot(112 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 234 
%             plot(112 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 235  
%             plot(113 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 235  
%             plot(113 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 235  
%             plot(113 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 235  
%             plot(113 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 237 
%             plot(114 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 237
%             plot(114 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 237
%             plot(114 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 237
%             plot(114 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  238 
%             plot(115 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  238 
%             plot(115 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  238 
%             plot(115 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  238 
%             plot(115 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 239  
%             plot(116 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 239  
%             plot(116 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 239  
%             plot(116 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 239  
%             plot(116 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 240  
%             plot(117 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 240  
%             plot(117 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 240  
%             plot(117 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 240  
%             plot(117 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 241 
%             plot(118 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 241 
%             plot(118 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 241 
%             plot(118 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 241 
%             plot(118 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 242 
%             plot(119 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 242 
%             plot(119 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 242 
%             plot(119 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 242 
%             plot(119 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 243  
%             plot(120 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 243  
%             plot(120 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 243  
%             plot(120 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 243  
%             plot(120 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 244  
%             plot(121 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 244  
%             plot(121 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 244  
%             plot(121 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 244  
%             plot(121 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 245  
%             plot(122 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 245  
%             plot(122 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 245  
%             plot(122 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 245  
%             plot(122 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 246  
%             plot(123 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 246  
%             plot(123 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 246  
%             plot(123 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 246  
%             plot(123 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 247  
%             plot(124 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 247  
%             plot(124 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 247  
%             plot(124 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 247  
%             plot(124 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 248 
%             plot(125 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 248 
%             plot(125 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 248 
%             plot(125 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 248 
%             plot(125 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  249 
%             plot(126 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  249 
%             plot(126 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  249 
%             plot(126 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  249 
%             plot(126 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 250
%             plot(127 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 250
%             plot(127 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 250
%             plot(127 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 250
%             plot(127 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 251  
%             plot(128 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 251  
%             plot(128 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 251  
%             plot(128 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 251  
%             plot(128 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 252 
%             plot(129 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 252 
%             plot(129 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 252 
%             plot(129 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 252 
%             plot(129 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 254  
%             plot(130 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 254  
%             plot(130 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 254  
%             plot(130 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 254  
%             plot(130 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 255  
%             plot(131 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 255  
%             plot(131 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 255  
%             plot(131 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 255  
%             plot(131 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 258  
%             plot(132 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 258  
%             plot(132 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 258  
%             plot(132 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 258  
%             plot(132 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 259  
%             plot(133 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 259  
%             plot(133 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 259  
%             plot(133 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 259  
%             plot(133 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 260 
%             plot(134 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 260 
%             plot(134 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 260 
%             plot(134 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 260 
%             plot(134 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 261  
%             plot(135 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 261  
%             plot(135 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 261  
%             plot(135 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 261  
%             plot(135 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 262 
%             plot(136 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 262 
%             plot(136 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 262 
%             plot(136 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 262 
%             plot(136 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 263  
%             plot(137 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 263  
%             plot(137 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 263  
%             plot(137 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 263  
%             plot(137 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 264  
%             plot(138 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 264
%             plot(138 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 264
%             plot(138 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 264
%             plot(138 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 265  
%             plot(139 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 265  
%             plot(139 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 265  
%             plot(139 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 265  
%             plot(139 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 266
%             plot(140 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 266
%             plot(140 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 266
%             plot(140 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 266
%             plot(140 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 267 
%             plot(141 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 267 
%             plot(141 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 267 
%             plot(141 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 267 
%             plot(141 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 268  
%             plot(142 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 268 
%             plot(142 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 268 
%             plot(142 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 268 
%             plot(142 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 269 
%             plot(143 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 269 
%             plot(143 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 269 
%             plot(143 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 269 
%             plot(143 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 270  
%             plot(144 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 270  
%             plot(144 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 270  
%             plot(144 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 270  
%             plot(144 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 271 
%             plot(145 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 271 
%             plot(145 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 271 
%             plot(145 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 271 
%             plot(145 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 272  
%             plot(146 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 272  
%             plot(146 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 272  
%             plot(146 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 272  
%             plot(146 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 273 
%             plot(147 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 273 
%             plot(147 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 273 
%             plot(147 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 273 
%             plot(147 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%          elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 274  
%             plot(148 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 274  
%             plot(148 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 274  
%             plot(148 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 274  
%             plot(148 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 275  
%             plot(149 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 275  
%             plot(149 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 275  
%             plot(149 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 275  
%             plot(149 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%          elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 276  
%             plot(150 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 276  
%             plot(150 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 276  
%             plot(150 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 276  
%             plot(150 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 278  
%             plot(151 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 278
%             plot(151 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 278
%             plot(151 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 278
%             plot(151 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%            elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 280 
%             plot(152 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 280 
%             plot(152 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 280 
%             plot(152 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 280 
%             plot(152 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 281  
%             plot(153 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 281  
%             plot(153 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 281  
%             plot(153 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 281  
%             plot(153 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%          elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 282   
%             plot(154 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 282   
%             plot(154 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 282   
%             plot(154 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 282   
%             plot(154 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) ==  283 
%             plot(155 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) ==  283 
%             plot(155 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) ==  283 
%             plot(155 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) ==  283 
%             plot(155 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 284  
%             plot(156 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 284  
%             plot(156 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 284  
%             plot(156 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 284  
%             plot(156 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 285  
%             plot(157 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 285  
%             plot(157 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 285  
%             plot(157 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 285  
%             plot(157 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%          elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 286  
%             plot(158 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 286  
%             plot(158 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 286  
%             plot(158 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 && d(i).task_or_stainCat(c) == 286  
%             plot(158 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 1 && d(i).task_or_stainCat(c) == 279   || d(i).task_or_stainCat(c) == 233   || d(i).task_or_stainCat(c) == 203 || d(i).task_or_stainCat(c) == 191   || d(i).task_or_stainCat(c) == 168   || d(i).task_or_stainCat(c) == 169   || d(i).task_or_stainCat(c) == 202   || d(i).task_or_stainCat(c) == 148   || d(i).task_or_stainCat(c) == 121 
%             plot(159 , d(i).effectVal(c), 'Color', ORANGE, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 1 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 279   || d(i).task_or_stainCat(c) == 233   || d(i).task_or_stainCat(c) == 203 || d(i).task_or_stainCat(c) == 191   || d(i).task_or_stainCat(c) == 168   || d(i).task_or_stainCat(c) == 169   || d(i).task_or_stainCat(c) == 202   || d(i).task_or_stainCat(c) == 148   || d(i).task_or_stainCat(c) == 121 
%             plot(159 , d(i).effectVal(c), 'Color', CYAN, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 1 &&  d(i).task_or_stainCat(c) == 279   || d(i).task_or_stainCat(c) == 233   || d(i).task_or_stainCat(c) == 203 || d(i).task_or_stainCat(c) == 191   || d(i).task_or_stainCat(c) == 168   || d(i).task_or_stainCat(c) == 169   || d(i).task_or_stainCat(c) == 202   || d(i).task_or_stainCat(c) == 148   || d(i).task_or_stainCat(c) == 121 
%             plot(159 , d(i).effectVal(c), 'Color', MAGENTA, 'marker', 'square', 'LineWidth',2 )
% 
%         elseif d(i).ModelStat == 0 && d(i).Species == 0 &&  d(i).task_or_stainCat(c) == 279   || d(i).task_or_stainCat(c) == 233   || d(i).task_or_stainCat(c) == 203 || d(i).task_or_stainCat(c) == 191   || d(i).task_or_stainCat(c) == 168   || d(i).task_or_stainCat(c) == 169   || d(i).task_or_stainCat(c) == 202   || d(i).task_or_stainCat(c) == 148   || d(i).task_or_stainCat(c) == 121 
%             plot(159 , d(i).effectVal(c), 'Color', GREEN, 'marker', 'square', 'LineWidth',2 )
% 
% 
%         end
%     end
% end



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


f13 = figure;
nlp_fig_prep(f13, "Portrait")
a13 = axes;
nlp_axes_prep(a13)
xlim([0 6000])
ylim([0 80])
title("Force NOT RIGHT :(!!")
xlabel("Newtons?????")
ylabel("Frequency")
hold on
h1 = nlp_hist_stair2(COMBONewtonsRatFF, 0, 6000, 50, 0);
h1.Color = ORANGE;
h1.LineWidth = 2;
h2 = nlp_hist_stair2(COMBONewtonsMiceFF, 0, 6000, 50, 1);
h2.Color = CYAN;
h2.LineWidth = 2;
h3 = nlp_hist_stair2(COMBONewtonsRatFS, 0, 6000, 50, 1.5);
h3.Color = MAGENTA;
h3.LineWidth = 2;
h4 = nlp_hist_stair2(COMBONewtonsMiceFS, 0, 6000, 50, 2);
h4.Color = GREEN;
h4.LineWidth = 2;


f14 = figure;
nlp_fig_prep(f14, "Portrait");
a14 = axes;
nlp_axes_prep(a14);
xlim([-1 248])
ylim([-0.001 100])
hold on
clear i
ylabel('% of Effects Calculable')
xlabel('Individ. Paper Num.')
for i = 1:length(d)
if d(i).ModelStat == 1 && d(i).Species == 1
    plot(i,d(i).PercentofMainEffectsCalc, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
elseif d(i).ModelStat == 1 && d(i).Species == 0
   plot(i,d(i).PercentofMainEffectsCalc, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
elseif d(i).ModelStat == 0 && d(i).Species == 1
    plot(i,d(i).PercentofMainEffectsCalc, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
elseif d(i).ModelStat == 0 && d(i).Species == 0
    plot(i,d(i).PercentofMainEffectsCalc, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
end
end






%{
% Behavior and stains graphs again with mean of papers and mean and range;
utilizing tables instead of graphs

f15 = figure;
nlp_fig_prep(f15, "Portrait");
a15 = axes;
nlp_axes_prep(a15);
ylabel("Cohens d Effect Sizes")
title("Behavioral Effect Sizes")
text(18, 10, "Free Fall-Like Weight Drop (WD) Model and Rats", "Color", ORANGE)
text(18, 9.5, "Free Fall-Like Weight Drop (WD) Model and Mice", "Color", CYAN)
text(18, 9, "Fixed Surface Weight Drop (WD) Model and Rats", "Color", MAGENTA)
text(18, 8.5, "Fixed Surface Weight Drop (WD) Model and Mice", "Color", GREEN)
set(gca, 'xticklabels', NewBehavioral_names)
ax15.XAxis.FontSize = 11;
axis padded
ylim([-0.1 12])
xticks(1:32)
xtickangle(90)
hold on
plot(0.8, MeanOFTRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(0.9, MeanOFTMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(1.1, MeanOFTRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(1.2, MeanOFTMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(0.8, Mean_MeanOFTRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(0.9, Mean_MeanOFTMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(1.1, Mean_MeanOFTRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(1.2, Mean_MeanOFTMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([0.8; 0.8], [Range_OFTRFF; Range_OFTRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([0.9; 0.9], [Range_OFTMFF; Range_OFTMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([1.1; 1.1], [Range_OFTRFS; Range_OFTRFS], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([1.2; 1.2], [Range_OFTMFS; Range_OFTMFS], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(1.8, MeanYMazeRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(1.9, MeanYMazeMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)  
plot(2.1, MeanYMazeRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(2.2, MeanYMazeMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(1.8, Mean_MeanYMazeRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(1.9, Mean_MeanYMazeMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(2.1, Mean_MeanYMazeRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(2.2, Mean_MeanYMazeMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([1.8; 1.8], [Range_YMazeRFF(1); Range_YMazeRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([1.9; 1.9], [Range_YMazeMFF(1); Range_YMazeMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([2.1; 2.1], [Range_YMazeRFS(1); Range_YMazeRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([2.2; 2.2], [Range_YMazeMFS(1); Range_YMazeMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(2.8, MeanNORRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(2.9, MeanNORMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(3.1, MeanNORRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(3.2, MeanNORMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(2.8, Mean_MeanNORRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(2.9, Mean_MeanNORMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(3.1, Mean_MeanNORRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(3.2, Mean_MeanNORMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([2.8; 2.8], [Range_NORRFF(1); Range_NORRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([2.9; 2.9], [Range_NORMFF(1); Range_NORMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([3.1; 3.1], [Range_NORRFS(1); Range_NORRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([3.2; 3.2], [Range_NORMFS(1); Range_NORMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(3.8, MeanEPMRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(3.9, MeanEPMMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(4.1, MeanEPMRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(4.2, MeanEPMMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(3.8, Mean_MeanEPMRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(3.9, Mean_MeanEPMMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(4.1, Mean_MeanEPMRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(4.2, Mean_MeanEPMMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([3.8; 3.8], [Range_EPMRFF(1); Range_EPMRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([3.9; 3.9], [Range_EPMMFF(1); Range_EPMMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([4.1; 4.1], [Range_EPMRFS(1); Range_EPMRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([4.2; 4.2], [Range_EPMMFS(1); Range_EPMMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(4.8, MeanLocomotorActRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)  
plot(4.9, MeanLocomotorActMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)  
plot(5.1, MeanLocomotorActRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(5.2, MeanLocomotorActMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(4.8, Mean_MeanLocomotorActRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(4.9, Mean_MeanLocomotorActMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(5.1, Mean_MeanLocomotorActRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(5.2, Mean_MeanLocomotorActMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([4.8; 4.8], [Range_LocomotorActRFF(1); Range_LocomotorActRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([4.9; 4.9], [Range_LocomotorActMFF(1); Range_LocomotorActMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([5.1; 5.1], [Range_LocomotorActRFS(1); Range_LocomotorActRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([5.2; 5.2], [Range_LocomotorActMFS(1); Range_LocomotorActMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(5.8, MeanRotarodRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(5.9, MeanRotarodMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(6.1, MeanRotarodRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)  
plot(6.2, MeanRotarodMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(5.8, Mean_MeanRotarodRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(5.9, Mean_MeanRotarodMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(6.1, Mean_MeanRotarodRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(6.2, Mean_MeanRotarodMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([5.8; 5.8], [Range_RotarodRFF(1); Range_RotarodRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([5.9; 5.9], [Range_RotarodMFF(1); Range_RotarodMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([6.1; 6.1], [Range_RotarodRFS(1); Range_RotarodRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([6.2; 6.2], [Range_RotarodMFS(1); Range_RotarodMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(6.8, MeanForcedSwimRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(6.9, MeanForcedSwimMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(7.1, MeanForcedSwimRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(7.2, MeanForcedSwimMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(6.8, Mean_MeanForcedSwimRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(6.9, Mean_MeanForcedSwimMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(7.1, Mean_MeanForcedSwimRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(7.2, Mean_MeanForcedSwimMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([6.8; 6.8], [Range_ForcedSwimRFF(1); Range_ForcedSwimRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([6.9; 6.9], [Range_ForcedSwimMFF(1); Range_ForcedSwimMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([7.1; 7.1], [Range_ForcedSwimRFS(1); Range_ForcedSwimRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([7.2; 7.2], [Range_ForcedSwimMFS(1); Range_ForcedSwimMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(7.8, MeanBeamWalkRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(7.9, MeanBeamWalkMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(8.1, MeanBeamWalkRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(8.2, MeanBeamWalkMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(7.8, Mean_MeanBeamWalkRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(7.9, Mean_MeanBeamWalkMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(8.1, Mean_MeanBeamWalkRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(8.2, Mean_MeanBeamWalkMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([7.8; 7.8], [Range_BeamWalkRFF(1); Range_BeamWalkRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([7.9; 7.9], [Range_BeamWalkMFF(1); Range_BeamWalkMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([8.1; 8.1], [Range_BeamWalkRFS(1); Range_BeamWalkRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([8.2; 8.2], [Range_BeamWalkMFS(1); Range_BeamWalkMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(8.8, MeanVonFreyRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)  
plot(8.9, MeanVonFreyMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)  
plot(9.1, MeanVonFreyRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)  
plot(9.2, MeanVonFreyMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)  
plot(8.8, Mean_MeanVonFreyRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(8.9, Mean_MeanVonFreyMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(9.1, Mean_MeanVonFreyRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(9.2, Mean_MeanVonFreyMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot([8.8; 8.8], [Range_VonFreyRFF(1); Range_VonFreyRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([8.9; 8.9], [Range_VonFreyMFF(1); Range_VonFreyMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([9.1; 9.1], [Range_VonFreyRFS(1); Range_VonFreyRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([9.2; 9.2], [Range_VonFreyMFS(1); Range_VonFreyMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  

plot(9.8, MeanResIntrudRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(9.9, MeanResIntrudMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(10.1, MeanResIntrudRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(10.2, MeanResIntrudMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(9.8, Mean_MeanResIntrudRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(9.9, Mean_MeanResIntrudMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(10.1, Mean_MeanResIntrudRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(10.2, Mean_MeanResIntrudMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([9.8; 9.8], [Range_ResIntrudRFF(1); Range_ResIntrudRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([9.9; 9.9], [Range_ResIntrudMFF(1); Range_ResIntrudMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([10.1; 10.1], [Range_ResIntrudRFS(1); Range_ResIntrudRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([10.2; 10.2], [Range_ResIntrudMFS(1); Range_ResIntrudMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(10.8, MeanTailSusRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(10.9, MeanTailSusMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(11.1, MeanTailSusRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(11.2, MeanTailSusMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(10.8, Mean_MeanTailSusRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(10.9, Mean_MeanTailSusMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(11.1, Mean_MeanTailSusRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(11.2, Mean_MeanTailSusMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([10.8; 10.8], [Range_TailSusRFF(1); Range_TailSusRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([10.9; 10.9], [Range_TailSusMFF(1); Range_TailSusMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([11.1; 11.1], [Range_TailSusRFS(1); Range_TailSusRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([11.2; 11.2], [Range_TailSusMFS(1); Range_TailSusMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(11.8, MeanChambersSocRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(11.9, MeanChambersSocMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(12.1, MeanChambersSocRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(12.2, MeanChambersSocMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(11.8, Mean_MeanChambersSocRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(11.9, Mean_MeanChambersSocMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(12.1, Mean_MeanChambersSocRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(12.2, Mean_MeanChambersSocMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([11.8; 11.8], [Range_ChambersSocRFF(1); Range_ChambersSocRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([11.9; 11.9], [Range_ChambersSocMFF(1); Range_ChambersSocMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([12.1; 12.1], [Range_ChambersSocRFS(1); Range_ChambersSocRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([12.2; 12.2], [Range_ChambersSocMFS(1); Range_ChambersSocMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(12.8, MeanNeuroAssRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(12.9, MeanNeuroAssMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(13.1, MeanNeuroAssRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(13.2, MeanNeuroAssMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(12.8, Mean_MeanNeuroAssRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(12.9, Mean_MeanNeuroAssMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(13.1, Mean_MeanNeuroAssRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(13.2, Mean_MeanNeuroAssMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([12.8; 12.8], [Range_NeuroAssRFF(1); Range_NeuroAssRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([12.9; 12.9], [Range_NeuroAssMFF(1); Range_NeuroAssMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([13.1; 13.1], [Range_NeuroAssRFS(1); Range_NeuroAssRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([13.2; 13.2], [Range_NeuroAssMFS(1); Range_NeuroAssMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(13.8, MeanMorrisWaterRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(13.9, MeanMorrisWaterMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(14.1, MeanMorrisWaterRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(14.2, MeanMorrisWaterMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(13.8, Mean_MeanMorrisWaterRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(13.9, Mean_MeanMorrisWaterMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(14.1, Mean_MeanMorrisWaterRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(14.2, Mean_MeanMorrisWaterMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([13.8; 13.8], [Range_MorrisWaterRFF(1); Range_MorrisWaterRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([13.9; 13.9], [Range_MorrisWaterMFF(1); Range_MorrisWaterMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([14.1; 14.1], [Range_MorrisWaterRFS(1); Range_MorrisWaterRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([14.2; 14.2], [Range_MorrisWaterMFS(1); Range_MorrisWaterMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(14.8, MeanBarnesRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(14.9, MeanBarnesMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(15.1, MeanBarnesRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(15.2, MeanBarnesMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(14.8, Mean_MeanBarnesRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(14.9, Mean_MeanBarnesMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(15.1, Mean_MeanBarnesRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(15.2, Mean_MeanBarnesMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([14.8; 14.8], [Range_BarnesRFF(1); Range_BarnesRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([14.9; 14.9], [Range_BarnesMFF(1); Range_BarnesMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([15.1; 15.1], [Range_BarnesRFS(1); Range_BarnesRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([15.2; 15.2], [Range_BarnesMFS(1); Range_BarnesMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(15.8, MeanBottleChoiceSaccRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(15.9, MeanBottleChoiceSaccMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(16.1, MeanBottleChoiceSaccRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(16.2, MeanBottleChoiceSaccMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(15.8, Mean_MeanBottleChoiceSaccRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(15.9, Mean_MeanBottleChoiceSaccMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(16.1, Mean_MeanBottleChoiceSaccRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(16.2, Mean_MeanBottleChoiceSaccMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([15.8; 15.8], [Range_BottleChoiceSaccRFF(1); Range_BottleChoiceSaccRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([15.9; 15.9], [Range_BottleChoiceSaccMFF(1); Range_BottleChoiceSaccMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([16.1; 16.1], [Range_BottleChoiceSaccRFS(1); Range_BottleChoiceSaccRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([16.2; 16.2], [Range_BottleChoiceSaccMFS(1); Range_BottleChoiceSaccRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(16.8, MeanOptomotorRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(16.9, MeanOptomotorMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(17.1, MeanOptomotorRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(17.2, MeanOptomotorMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(16.8, Mean_MeanOptomotorRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(16.9, Mean_MeanOptomotorMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(17.1, Mean_MeanOptomotorRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(17.2, Mean_MeanOptomotorMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([16.8; 16.8], [Range_OptomotorRFF(1); Range_OptomotorRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([16.9; 16.9], [Range_OptomotorMFF(1); Range_OptomotorMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([17.1; 17.1], [Range_OptomotorRFS(1); Range_OptomotorRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([17.2; 17.2], [Range_OptomotorMFS(1); Range_OptomotorMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(17.8, MeanMarbleBuryingRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(17.9, MeanMarbleBuryingMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(18.1, MeanMarbleBuryingRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(18.2, MeanMarbleBuryingMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(17.8, Mean_MeanMarbleBuryingRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(17.9, Mean_MeanMarbleBuryingMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(18.1, Mean_MeanMarbleBuryingRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(18.2, Mean_MeanMarbleBuryingMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([17.8; 17.8], [Range_MarbleBuryingRFF(1); Range_MarbleBuryingRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([17.9; 17.9], [Range_MarbleBuryingMFF(1); Range_MarbleBuryingMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([18.1; 18.1], [Range_MarbleBuryingRFS(1); Range_MarbleBuryingRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([18.2; 18.2], [Range_MarbleBuryingMFS(1); Range_MarbleBuryingMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(18.8, MeanNestletShreddingRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(18.9, MeanNestletShreddingMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(19.1, MeanNestletShreddingRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(19.2, MeanNestletShreddingMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(18.8, Mean_MeanNestletShreddingRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(18.9, Mean_MeanNestletShreddingMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(19.1, Mean_MeanNestletShreddingRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(19.2, Mean_MeanNestletShreddingMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([18.8; 18.8], [Range_NestletShreddingRFF(1); Range_NestletShreddingRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([18.9; 18.9], [Range_NestletShreddingMFF(1); Range_NestletShreddingMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([19.1; 19.1], [Range_NestletShreddingRFS(1); Range_NestletShreddingRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([19.2; 19.2], [Range_NestletShreddingMFS(1); Range_NestletShreddingMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(19.8, MeanHomeCageMonitorRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(19.9, MeanHomeCageMonitorMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(20.1, MeanHomeCageMonitorRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(20.2, MeanHomeCageMonitorMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(19.8, Mean_MeanHomeCageMonitorRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(19.9, Mean_MeanHomeCageMonitorMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(20.1, Mean_MeanHomeCageMonitorRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(20.2, Mean_MeanHomeCageMonitorMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([19.8; 19.8], [Range_HomeCageMonitorRFF(1); Range_HomeCageMonitorRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([19.9; 19.9], [Range_HomeCageMonitorMFF(1); Range_HomeCageMonitorMFF(2)] , 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([20.1; 20.1], [Range_HomeCageMonitorRFS(1); Range_HomeCageMonitorRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([20.2; 20.2], [Range_HomeCageMonitorMFS(1); Range_HomeCageMonitorMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(20.8, MeanSocSexInterRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(20.9, MeanSocSexInterMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(21.1, MeanSocSexInterRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(21.2, MeanSocSexInterMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(20.8, Mean_MeanSocSexInterRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(20.9, Mean_MeanSocSexInterMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(21.1, Mean_MeanSocSexInterRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(21.2, Mean_MeanSocSexInterMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([20.8; 20.8], [Range_SocSexInterRFF(1); Range_SocSexInterRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([20.9; 20.9], [Range_SocSexInterMFF(1); Range_SocSexInterMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([21.1; 21.1], [Range_SocSexInterRFS(1); Range_SocSexInterRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([21.2; 21.2], [Range_SocSexInterMFS(1); Range_SocSexInterMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(21.8, MeanLightDarkCPARRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(21.9, MeanLightDarkCPARMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(22.1, MeanLightDarkCPARRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(22.2, MeanLightDarkCPARMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(21.8, Mean_MeanLightDarkCPARRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(21.9, Mean_MeanLightDarkCPARMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(22.1, Mean_MeanLightDarkCPARRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(22.2, Mean_MeanLightDarkCPARMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([21.8; 21.8], [Range_LightDarkCPARRFF(1); Range_LightDarkCPARRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([21.9; 21.9], [Range_LightDarkCPARMFF(1); Range_LightDarkCPARMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([22.1; 22.1], [Range_LightDarkCPARRFS(1); Range_LightDarkCPARRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([22.2; 22.2], [Range_LightDarkCPARMFS(1); Range_LightDarkCPARMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(22.8, MeanWaterFindRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(22.9, MeanWaterFindMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(23.1, MeanWaterFindRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(23.2, MeanWaterFindMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(22.8, Mean_MeanWaterFindRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(22.9, Mean_MeanWaterFindMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(23.1, Mean_MeanWaterFindRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(23.2, Mean_MeanWaterFindMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([22.8; 22.8], [Range_WaterFindRFF(1); Range_WaterFindRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([22.9; 22.9], [Range_WaterFindMFF(1); Range_WaterFindMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([23.1; 23.1], [Range_WaterFindRFS(1); Range_WaterFindRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([23.2; 23.2], [Range_WaterFindMFS(1); Range_WaterFindMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(23.8, MeanMechAlloRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(23.9, MeanMechAlloMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(24.1, MeanMechAlloRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(24.2, MeanMechAlloMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(23.8, Mean_MeanMechAlloRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(23.9, Mean_MeanMechAlloMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(24.1, Mean_MeanMechAlloRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(24.2, Mean_MeanMechAlloMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([23.8; 23.8], [Range_MechAlloRFF(1); Range_MechAlloRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([23.9; 23.9], [Range_MechAlloMFF(1); Range_MechAlloMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([24.1; 24.1], [Range_MechAlloRFS(1); Range_MechAlloRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([24.2; 24.2], [Range_MechAlloMFS(1); Range_MechAlloMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(24.8, MeanThermHyperRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(24.9, MeanThermHyperMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(25.1, MeanThermHyperRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(25.2, MeanThermHyperMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(24.8, Mean_MeanThermHyperRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(24.9, Mean_MeanThermHyperMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(25.1, Mean_MeanThermHyperRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(25.2, Mean_MeanThermHyperMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([24.8; 24.8], [Range_ThermHyperRFF(1); Range_ThermHyperRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([24.9; 24.9], [Range_ThermHyperMFF(1); Range_ThermHyperMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([25.1; 25.1], [Range_ThermHyperRFS(1); Range_ThermHyperRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([25.2; 25.2], [Range_ThermHyperMFS(1); Range_ThermHyperMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

%Only fem so not app plot(25.8, MeanUltraSonicVocalRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
% plot(25.9, MeanUltraSonicVocalMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
% plot(26.1, MeanUltraSonicVocalRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
% plot(26.2, MeanUltraSonicVocalMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
% plot(25.8, Mean_MeanUltraSonicVocalRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
% plot(25.9, Mean_MeanUltraSonicVocalMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
% plot(26.1, Mean_MeanUltraSonicVocalRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
% plot(26.2, Mean_MeanUltraSonicVocalMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
% plot([25.8; 25.8], [Range_UltraSonicVocalRFF(1); Range_UltraSonicVocalRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
% plot([25.9; 25.9], [Range_UltraSonicVocalMFF(1); Range_UltraSonicVocalMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
% plot([26.1; 26.1], [Range_UltraSonicVocalRFS(1); Range_UltraSonicVocalRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
% plot([26.2; 26.2], [Range_UltraSonicVocalMFS(1); Range_UltraSonicVocalMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(25.8, MeanStairCaseRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(25.9, MeanStairCaseMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(26.1, MeanStairCaseRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(26.2, MeanStairCaseMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(25.8, Mean_MeanStairCaseRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(25.9, Mean_MeanStairCaseMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(26.1, Mean_MeanStairCaseRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(26.2, Mean_MeanStairCaseMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([25.8; 25.8], [Range_StairCaseRFF(1); Range_StairCaseRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([25.9; 25.9], [Range_StairCaseMFF(1); Range_StairCaseMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([26.1; 26.1], [Range_StairCaseRFS(1); Range_StairCaseRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([26.2; 26.2], [Range_StairCaseMFS(1); Range_StairCaseMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(26.8, MeanGridWalkRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(26.9, MeanGridWalkMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(27.1, MeanGridWalkRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(27.2, MeanGridWalkMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(26.8, Mean_MeanGridWalkRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(26.9, Mean_MeanGridWalkMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(27.1, Mean_MeanGridWalkRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(27.2, Mean_MeanGridWalkMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([26.8; 26.8], [Range_GridWalkRFF(1); Range_GridWalkRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([26.9; 26.9], [Range_GridWalkMFF(1); Range_GridWalkMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([27.1; 27.1], [Range_GridWalkRFS(1); Range_GridWalkRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([27.2; 27.2], [Range_GridWalkMFS(1); Range_GridWalkMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(27.8, MeanNoveltySuppFeedRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(27.9, MeanNoveltySuppFeedMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(28.1, MeanNoveltySuppFeedRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(28.2, MeanNoveltySuppFeedMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(27.8, Mean_MeanNoveltySuppFeedRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(27.9, Mean_MeanNoveltySuppFeedMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(28.1, Mean_MeanNoveltySuppFeedRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(28.2, Mean_MeanNoveltySuppFeedMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([27.8; 27.8], [Range_NoveltySuppFeedRFF(1); Range_NoveltySuppFeedRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([27.9; 27.9], [Range_NoveltySuppFeedMFF(1); Range_NoveltySuppFeedMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([28.1; 28.1], [Range_NoveltySuppFeedRFS(1); Range_NoveltySuppFeedRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([28.2; 28.2], [Range_NoveltySuppFeedMFS(1); Range_NoveltySuppFeedMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(28.8, MeanHoleBoardRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(28.9, MeanHoleBoardMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(29.1, MeanHoleBoardRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(29.2, MeanHoleBoardMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(28.8, Mean_MeanHoleBoardRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(28.9, Mean_MeanHoleBoardMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(29.1, Mean_MeanHoleBoardRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(29.2, Mean_MeanHoleBoardMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([28.8; 28.8], [Range_HoleBoardRFF(1); Range_HoleBoardRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([28.9; 28.9], [Range_HoleBoardMFF(1); Range_HoleBoardMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([29.1; 29.1], [Range_HoleBoardRFS(1); Range_HoleBoardRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([29.2; 29.2], [Range_HoleBoardMFS(1); Range_HoleBoardMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(29.8, MeanTouchScrRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(29.9, MeanTouchScrMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(30.1, MeanTouchScrRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(30.2, MeanTouchScrMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(29.8, Mean_MeanTouchScrRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(29.9, Mean_MeanTouchScrMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(30.1, Mean_MeanTouchScrRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(30.2, Mean_MeanTouchScrMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([29.8; 29.8], [Range_TouchScrRFF(1); Range_TouchScrRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([29.9; 29.9], [Range_TouchScrMFF(1); Range_TouchScrMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([30.1; 30.1], [Range_TouchScrRFS(1); Range_TouchScrRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([30.2; 30.2], [Range_TouchScrMFS(1); Range_TouchScrMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(30.8, MeanSplashTestRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(30.9, MeanSplashTestMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(31.1, MeanSplashTestRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(31.2, MeanSplashTestMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)  
plot(30.8, Mean_MeanSplashTestRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(30.9, Mean_MeanSplashTestMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(31.1, Mean_MeanSplashTestRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(31.2, Mean_MeanSplashTestMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot([30.8; 30.8], [Range_SplashTestRFF(1); Range_SplashTestRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([30.9; 30.9], [Range_SplashTestMFF(1); Range_SplashTestMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([31.1; 31.1], [Range_SplashTestRFS(1); Range_SplashTestRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([31.2; 31.2], [Range_SplashTestMFS(1); Range_SplashTestMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  





f16 = figure;
nlp_fig_prep(f16, "Portrait");
a16 = axes;
nlp_axes_prep(a16);
ylabel("Cohens d Effect Sizes")
title("Stain/Tissue Measure Effect Sizes")
text(1, 23, "Free Fall-Like Weight Drop (WD) Model and Rats", "Color", ORANGE)
text(1, 22, "Free Fall-Like Weight Drop (WD) Model and Mice", "Color", CYAN)
text(1, 21, "Fixed Surface Weight Drop (WD) Model and Rats", "Color", MAGENTA)
text(1, 20, "Fixed Surface Weight Drop (WD) Model and Mice", "Color", GREEN)
xticks(1:34)
xtickangle(90)
ax16.XAxis.FontSize = 11;
axis padded
ylim([-0.1 25])
set(gca, 'xticklabels', NewStain_names)
hold on
plot(0.8, MeanGFAP_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(0.9, MeanGFAP_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(1.1, MeanGFAP_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(1.2, MeanGFAP_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)  
plot(0.8, Mean_MeanGFAP_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(0.9, Mean_MeanGFAP_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(1.1, Mean_MeanGFAP_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(1.2, Mean_MeanGFAP_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot([0.8; 0.8], [Range_GFAP_RFF(1); Range_GFAP_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([0.9; 0.9], [Range_GFAP_MFF(1); Range_GFAP_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([1.1; 1.1], [Range_GFAP_RFS(1); Range_GFAP_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([1.2; 1.2], [Range_GFAP_MFS(1); Range_GFAP_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  

plot(1.8, MeanIBA_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(1.9, MeanIBA_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(2.1, MeanIBA_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(2.2, MeanIBA_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(1.8, Mean_MeanIBA_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(1.9, Mean_MeanIBA_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(2.1, Mean_MeanIBA_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(2.2, Mean_MeanIBA_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([1.8; 1.8], [Range_IBA_RFF(1); Range_IBA_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([1.9; 1.9], [Range_IBA_MFF(1); Range_IBA_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([2.1; 2.1], [Range_IBA_RFS(1); Range_IBA_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([2.2; 2.2], [Range_IBA_MFS(1); Range_IBA_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(2.8, MeanPTAU_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(2.9, MeanPTAU_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(3.1, MeanPTAU_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(3.2, MeanPTAU_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(2.8, Mean_MeanPTAU_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(2.9, Mean_MeanPTAU_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(3.1, Mean_MeanPTAU_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(3.2, Mean_MeanPTAU_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([2.8; 2.8], [Range_PTAU_RFF(1); Range_PTAU_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([2.9; 2.9], [Range_PTAU_MFF(1); Range_PTAU_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([3.1; 3.1], [Range_PTAU_RFS(1); Range_PTAU_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([3.2; 3.2], [Range_PTAU_MFS(1); Range_PTAU_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(3.8, MeanNeuNRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(3.9, MeanNeuNMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(4.1, MeanNeuNRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(4.2, MeanNeuNMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(3.8, Mean_MeanNeuNRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(3.9, Mean_MeanNeuNMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(4.1, Mean_MeanNeuNRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(4.2, Mean_MeanNeuNMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([3.8; 3.8], [Range_NeuNRFF(1); Range_NeuNRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([3.9; 3.9], [Range_NeuNMFF(1); Range_NeuNMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([4.1; 4.1], [Range_NeuNRFS(1); Range_NeuNRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([4.2; 4.2], [Range_NeuNMFS(1); Range_NeuNMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(4.8, MeanPNFH_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(4.9, MeanPNFH_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(5.1, MeanPNFH_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(5.2, MeanPNFH_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(4.8, Mean_MeanPNFH_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(4.9, Mean_MeanPNFH_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(5.1, Mean_MeanPNFH_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(5.2, Mean_MeanPNFH_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([4.8; 4.8], [Range_PNFH_RFF(1); Range_PNFH_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([4.9; 4.9], [Range_PNFH_MFF(1); Range_PNFH_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([5.1; 5.1], [Range_PNFH_RFS(1); Range_PNFH_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([5.2; 5.2], [Range_PNFH_MFS(1); Range_PNFH_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(5.8, MeanFActinRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(5.9, MeanFActinMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(6.1, MeanFActinRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(6.2, MeanFActinMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(5.8, Mean_MeanFActinRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(5.9, Mean_MeanFActinMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(6.1, Mean_MeanFActinRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(6.2, Mean_MeanFActinMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([5.8; 5.8], [Range_FActinRFF(1); Range_FActinRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([5.9; 5.9], [Range_FActinMFF(1); Range_FActinMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([6.1; 6.1], [Range_FActinRFS(1); Range_FActinRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([6.2; 6.2], [Range_FActinMFS(1); Range_FActinMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(6.8, MeanBetaTubRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(6.9, MeanBetaTubMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(7.1, MeanBetaTubRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(7.2, MeanBetaTubMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(6.8, Mean_MeanBetaTubRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(6.9, Mean_MeanBetaTubMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(7.1, Mean_MeanBetaTubRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(7.2, Mean_MeanBetaTubMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([6.8; 6.8], [Range_BetaTubRFF(1); Range_BetaTubRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([6.9; 6.9], [Range_BetaTubMFF(1); Range_BetaTubMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([7.1; 7.1], [Range_BetaTubRFS(1); Range_BetaTubRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([7.2; 7.2], [Range_BetaTubMFS(1); Range_BetaTubMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(7.8, MeanHEMAEOXRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(7.9, MeanHEMAEOXMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(8.1, MeanHEMAEOXRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(8.2, MeanHEMAEOXMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(7.8, Mean_MeanHEMAEOXRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(7.9, Mean_MeanHEMAEOXMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(8.1, Mean_MeanHEMAEOXRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(8.2, Mean_MeanHEMAEOXMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([7.8; 7.8], [Range_HEMAEOXRFF(1); Range_HEMAEOXRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([7.9; 7.9], [Range_HEMAEOXMFF(1); Range_HEMAEOXMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([8.1; 8.1], [Range_HEMAEOXRFS(1); Range_HEMAEOXRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([8.2; 8.2], [Range_HEMAEOXMFS(1); Range_HEMAEOXMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(8.8, MeanVEGF_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(8.9, MeanVEGF_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(9.1, MeanVEGF_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(9.2, MeanVEGF_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(8.8, Mean_MeanVEGF_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(8.9, Mean_MeanVEGF_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(9.1, Mean_MeanVEGF_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(9.2, Mean_MeanVEGF_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([8.8; 8.8], [Range_VEGF_RFF(1); Range_VEGF_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([8.9; 8.9], [Range_VEGF_MFF(1); Range_VEGF_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([9.1; 9.1], [Range_VEGF_RFS(1); Range_VEGF_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([9.2; 9.2], [Range_VEGF_MFS(1); Range_VEGF_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(9.8, MeanFluorJadeBRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(9.9, MeanFluorJadeBMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(10.1, MeanFluorJadeBRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(10.2, MeanFluorJadeBMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(9.8, Mean_MeanFluorJadeBRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(9.9, Mean_MeanFluorJadeBMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(10.1, Mean_MeanFluorJadeBRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(10.2, Mean_MeanFluorJadeBMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([9.8; 9.8], [Range_FluorJadeBRFF(1); Range_FluorJadeBRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([9.9; 9.9], [Range_FluorJadeBMFF(1); Range_FluorJadeBMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([10.1; 10.1], [Range_FluorJadeBRFS(1); Range_FluorJadeBRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([10.2; 10.2], [Range_FluorJadeBMFS(1); Range_FluorJadeBMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(10.8, MeanHECresNissRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(10.9, MeanHECresNissMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(11.1, MeanHECresNissRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(11.2, MeanHECresNissMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(10.8, Mean_MeanHECresNissRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(10.9, Mean_MeanHECresNissMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(11.1, Mean_MeanHECresNissRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(11.2, Mean_MeanHECresNissMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([10.8; 10.8], [Range_HECresNissRFF(1); Range_HECresNissRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([10.9; 10.9], [Range_HECresNissMFF(1); Range_HECresNissMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([11.1; 11.1], [Range_HECresNissRFS(1); Range_HECresNissRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([11.2; 11.2], [Range_HECresNissMFS(1); Range_HECresNissMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(11.8, MeanBRDU_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(11.9, MeanBRDU_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(12.1, MeanBRDU_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(12.2, MeanBRDU_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(11.8, Mean_MeanBRDU_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(11.9, Mean_MeanBRDU_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(12.1, Mean_MeanBRDU_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(12.2, Mean_MeanBRDU_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([11.8; 11.8], [Range_BRDU_RFF(1); Range_BRDU_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([11.9; 11.9], [Range_BRDU_MFF(1); Range_BRDU_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([12.1; 12.1], [Range_BRDU_RFS(1); Range_BRDU_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([12.2; 12.2], [Range_BRDU_MFS(1); Range_BRDU_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(12.8, MeanOligNG2_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(12.9, MeanOligNG2_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(13.1, MeanOligNG2_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(13.2, MeanOligNG2_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(12.8, Mean_MeanOligNG2_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(12.9, Mean_MeanOligNG2_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(13.1, Mean_MeanOligNG2_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(13.2, Mean_MeanOligNG2_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([12.8; 12.8], [Range_OligNG2_RFF(1); Range_OligNG2_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([12.9; 12.9], [Range_OligNG2_MFF(1); Range_OligNG2_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([13.1; 13.1], [Range_OligNG2_RFS(1); Range_OligNG2_RFS(2)] , 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([13.2; 13.2], [Range_OligNG2_MFS(1); Range_OligNG2_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(13.8, MeanCadaverine_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(13.9, MeanCadaverine_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(14.1, MeanCadaverine_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(14.2, MeanCadaverine_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(13.8, Mean_MeanCadaverine_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(13.9, Mean_MeanCadaverine_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(14.1, Mean_MeanCadaverine_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(14.2, Mean_MeanCadaverine_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([13.8; 13.8], [Range_Cadaverine_RFF(1); Range_Cadaverine_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([13.9; 13.9], [Range_Cadaverine_MFF(1); Range_Cadaverine_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([14.1; 14.1], [Range_Cadaverine_RFS(1); Range_Cadaverine_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([14.2; 14.2], [Range_Cadaverine_MFS(1); Range_Cadaverine_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(14.8, MeanZO1_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(14.9, MeanZO1_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(15.1, MeanZO1_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(15.2, MeanZO1_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(14.8, Mean_MeanZO1_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(14.9, Mean_MeanZO1_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(15.1, Mean_MeanZO1_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(15.2, Mean_MeanZO1_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([14.8; 14.8], [Range_ZO1_RFF(1); Range_ZO1_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([14.9; 14.9], [Range_ZO1_MFF(1); Range_ZO1_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([15.1; 15.1], [Range_ZO1_RFS(1); Range_ZO1_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([15.2; 15.2], [Range_ZO1_MFS(1); Range_ZO1_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(15.8, MeanGlut1_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)  
plot(15.9, MeanGlut1_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(16.1, MeanGlut1_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(16.2, MeanGlut1_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(15.8, Mean_MeanGlut1_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(15.9, Mean_MeanGlut1_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(16.1, Mean_MeanGlut1_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(16.2, Mean_MeanGlut1_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([15.8; 15.8], [Range_Glut1_RFF(1); Range_Glut1_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([15.9; 15.9], [Range_Glut1_MFF(1); Range_Glut1_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([16.1; 16.1], [Range_Glut1_RFS(1); Range_Glut1_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([16.2; 16.2], [Range_Glut1_MFS(1); Range_Glut1_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(16.8, MeanCD45_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(16.9, MeanCD45_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(17.1, MeanCD45_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(17.2, MeanCD45_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(16.8, Mean_MeanCD45_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(16.9, Mean_MeanCD45_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(17.1, Mean_MeanCD45_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(17.2, Mean_MeanCD45_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([16.8; 16.8], [Range_CD45_RFF(1); Range_CD45_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([16.9; 16.9], [Range_CD45_MFF(1); Range_CD45_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([17.1; 17.1], [Range_CD45_RFS(1); Range_CD45_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([17.2; 17.2], [Range_CD45_MFS(1); Range_CD45_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(17.8, MeanBetaDystro_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(17.9, MeanBetaDystro_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(18.1, MeanBetaDystro_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(18.2, MeanBetaDystro_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(17.8, Mean_MeanBetaDystro_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(17.9, Mean_MeanBetaDystro_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(18.1, Mean_MeanBetaDystro_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(18.2, Mean_MeanBetaDystro_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([17.8; 17.8], [Range_BetaDystro_RFF(1); Range_BetaDystro_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([17.9; 17.9], [Range_BetaDystro_MFF(1); Range_BetaDystro_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([18.1; 18.1], [Range_BetaDystro_RFS(1); Range_BetaDystro_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([18.2; 18.2], [Range_BetaDystro_MFS(1); Range_BetaDystro_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(18.8, MeanAQP4_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(18.9, MeanAQP4_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(19.1, MeanAQP4_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(19.2, MeanAQP4_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(18.8, Mean_MeanAQP4_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(18.9, Mean_MeanAQP4_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(19.1, Mean_MeanAQP4_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(19.2, Mean_MeanAQP4_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([18.8; 18.8], [Range_AQP4_RFF(1); Range_AQP4_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([18.9; 18.9], [Range_AQP4_MFF(1); Range_AQP4_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([19.1; 19.1], [Range_AQP4_RFS(1); Range_AQP4_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([19.2; 19.2], [Range_AQP4_MFS(1); Range_AQP4_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(19.8, MeanTUNEL_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(19.9, MeanTUNEL_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(20.1, MeanTUNEL_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(20.2, MeanTUNEL_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(19.8, Mean_MeanTUNEL_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(19.9, Mean_MeanTUNEL_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(20.1, Mean_MeanTUNEL_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(20.2, Mean_MeanTUNEL_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([19.8; 19.8], [Range_TUNEL_RFF(1); Range_TUNEL_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([19.9; 19.9], [Range_TUNEL_MFF(1); Range_TUNEL_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([20.1; 20.1], [Range_TUNEL_RFS(1); Range_TUNEL_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([20.2; 20.2], [Range_TUNEL_MFS(1); Range_TUNEL_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(20.8, MeanParVal_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(20.9, MeanParVal_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(21.1, MeanParVal_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(21.2, MeanParVal_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(20.8, Mean_MeanParVal_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(20.9, Mean_MeanParVal_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(21.1, Mean_MeanParVal_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(21.2, Mean_MeanParVal_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([20.8; 20.8], [Range_ParVal_RFF(1); Range_ParVal_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([20.9; 20.9], [Range_ParVal_MFF(1); Range_ParVal_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([21.1; 21.1], [Range_ParVal_RFS(1); Range_ParVal_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([21.2; 21.2], [Range_ParVal_MFS(1); Range_ParVal_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(21.8, MeanPeriNeuron_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(21.9, MeanPeriNeuron_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(22.1, MeanPeriNeuron_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(22.2, MeanPeriNeuron_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(21.8, Mean_MeanPeriNeuron_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(21.9, Mean_MeanPeriNeuron_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(22.1, Mean_MeanPeriNeuron_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(22.2, Mean_MeanPeriNeuron_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([21.8; 21.8], [Range_PeriNeuron_RFF(1); Range_PeriNeuron_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([21.9; 21.9], [Range_PeriNeuron_MFF(1); Range_PeriNeuron_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([22.1; 22.1], [Range_PeriNeuron_RFS(1); Range_PeriNeuron_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([22.2; 22.2], [Range_PeriNeuron_MFS(1); Range_PeriNeuron_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(22.8, MeanParValPeriNeuron_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)  
plot(22.9, MeanParValPeriNeuron_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(23.1, MeanParValPeriNeuron_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(23.2, MeanParValPeriNeuron_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)  
plot(22.8, Mean_MeanParValPeriNeuron_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(22.9, Mean_MeanParValPeriNeuron_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(23.1, Mean_MeanParValPeriNeuron_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(23.2, Mean_MeanParValPeriNeuron_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot([22.8; 22.8], [Range_ParValPeriNeuron_RFF(1); Range_ParValPeriNeuron_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([22.9; 22.9], [Range_ParValPeriNeuron_MFF(1); Range_ParValPeriNeuron_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([23.1; 23.1], [Range_ParValPeriNeuron_RFS(1); Range_ParValPeriNeuron_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([23.2; 23.2], [Range_ParValPeriNeuron_MFS(1); Range_ParValPeriNeuron_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  

plot(23.8, MeanWhiteMattStereoRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(23.9, MeanWhiteMattStereoMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(24.1, MeanWhiteMattStereoRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(24.2, MeanWhiteMattStereoMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(23.8, Mean_MeanWhiteMattStereoRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(23.9, Mean_MeanWhiteMattStereoMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(24.1, Mean_MeanWhiteMattStereoRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(24.2, Mean_MeanWhiteMattStereoMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([23.8; 23.8], [Range_WhiteMattStereoRFF(1); Range_WhiteMattStereoRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([23.9; 23.9], [Range_WhiteMattStereoMFF(1); Range_WhiteMattStereoMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([24.1; 24.1], [Range_WhiteMattStereoRFS(1); Range_WhiteMattStereoRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([24.2; 24.2], [Range_WhiteMattStereoMFS(1); Range_WhiteMattStereoMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(24.8, MeanCaspase3RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(24.9, MeanCaspase3MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(25.1, MeanCaspase3RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(25.2, MeanCaspase3MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(24.8, Mean_MeanCaspase3RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(24.9, Mean_MeanCaspase3MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(25.1, Mean_MeanCaspase3RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(25.2, Mean_MeanCaspase3MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([24.8; 24.8], [Range_Caspase3RFF(1); Range_Caspase3RFF(2)] , 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([24.9; 24.9], [Range_Caspase3MFF(1); Range_Caspase3MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([25.1; 25.1], [Range_Caspase3RFS(1); Range_Caspase3RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([25.2; 25.2], [Range_Caspase3MFS(1); Range_Caspase3MFS(2)] , 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(25.8, MeanBCL2_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(25.9, MeanBCL2_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2)
plot(26.1, MeanBCL2_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(26.2, MeanBCL2_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(25.8, Mean_MeanBCL2_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(25.9, Mean_MeanBCL2_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(26.1, Mean_MeanBCL2_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(26.2, Mean_MeanBCL2_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([25.8; 25.8], [Range_BCL2_RFF(1); Range_BCL2_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([25.9; 25.9], [Range_BCL2_MFF(1); Range_BCL2_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([26.1; 26.1], [Range_BCL2_RFS(1); Range_BCL2_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([26.2; 26.2], [Range_BCL2_MFS(1); Range_BCL2_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(26.8, MeanBax_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(26.9, MeanBax_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(27.1, MeanBax_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(27.2, MeanBax_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(26.8, Mean_MeanBax_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(26.9, Mean_MeanBax_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(27.1, Mean_MeanBax_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(27.2, Mean_MeanBax_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([26.8; 26.8], [Range_Bax_RFF(1); Range_Bax_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([26.9; 26.9], [Range_Bax_MFF(1); Range_Bax_MFF(2)] , 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([27.1; 27.1], [Range_Bax_RFS(1); Range_Bax_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([27.2; 27.2], [Range_Bax_MFS(1); Range_Bax_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(27.8, MeanHT5_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)
plot(27.9, MeanHT5_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(28.1, MeanHT5_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(28.2, MeanHT5_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2)
plot(27.8, Mean_MeanHT5_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(27.9, Mean_MeanHT5_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(28.1, Mean_MeanHT5_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(28.2, Mean_MeanHT5_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot([27.8; 27.8], [Range_HT5_RFF(1); Range_HT5_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([27.9; 27.9], [Range_HT5_MFF(1); Range_HT5_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([28.1; 28.1], [Range_HT5_RFS(1); Range_HT5_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([28.2; 28.2], [Range_HT5_MFS(1); Range_HT5_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)

plot(28.8, MeanDopaBetaHydrox_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(28.9, MeanDopaBetaHydrox_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(29.1, MeanDopaBetaHydrox_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(29.2, MeanDopaBetaHydrox_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(28.8, Mean_MeanDopaBetaHydrox_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(28.9, Mean_MeanDopaBetaHydrox_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(29.1, Mean_MeanDopaBetaHydrox_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(29.2, Mean_MeanDopaBetaHydrox_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([28.8; 28.8], [Range_DopaBetaHydrox_RFF(1); Range_DopaBetaHydrox_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([28.9; 28.9], [Range_DopaBetaHydrox_MFF(1); Range_DopaBetaHydrox_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([29.1; 29.1], [Range_DopaBetaHydrox_RFS(1); Range_DopaBetaHydrox_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([29.2; 29.2], [Range_DopaBetaHydrox_MFS(1); Range_DopaBetaHydrox_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(29.8, MeanNK1R_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(29.9, MeanNK1R_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(30.1, MeanNK1R_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(30.2, MeanNK1R_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(29.8, Mean_MeanNK1R_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(29.9, Mean_MeanNK1R_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(30.1, Mean_MeanNK1R_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(30.2, Mean_MeanNK1R_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([29.8; 29.8], [Range_NK1R_RFF(1); Range_NK1R_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([29.9; 29.9], [Range_NK1R_MFF(1); Range_NK1R_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([30.1; 30.1], [Range_NK1R_RFS(1); Range_NK1R_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([30.2; 30.2], [Range_NK1R_MFS(1); Range_NK1R_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(30.8, MeanGAD67_RFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2)  
plot(30.9, MeanGAD67_MFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(31.1, MeanGAD67_RFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2) 
plot(31.2, MeanGAD67_MFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(30.8, Mean_MeanGAD67_RFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2)  
plot(30.9, Mean_MeanGAD67_MFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(31.1, Mean_MeanGAD67_RFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(31.2, Mean_MeanGAD67_MFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([30.8; 30.8], [Range_GAD67_RFF(1); Range_GAD67_RFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)  
plot([30.9; 30.9], [Range_GAD67_MFF(1); Range_GAD67_MFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([31.1; 31.1], [Range_GAD67_RFS(1); Range_GAD67_RFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([31.2; 31.2], [Range_GAD67_MFS(1); Range_GAD67_MFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 

plot(31.8, MeanDopaBetaHydrox_NeuNRFF, 'color', ORANGE, 'marker', 's', 'Linewidth', 2) 
plot(31.9, MeanDopaBetaHydrox_NeuNMFF, 'color', CYAN, 'marker', 's', 'Linewidth', 2) 
plot(32.1, MeanDopaBetaHydrox_NeuNRFS, 'color', MAGENTA, 'marker', 's', 'Linewidth', 2)
plot(32.2, MeanDopaBetaHydrox_NeuNMFS, 'color', GREEN, 'marker', 's', 'Linewidth', 2) 
plot(31.8, Mean_MeanDopaBetaHydrox_NeuNRFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(31.9, Mean_MeanDopaBetaHydrox_NeuNMFF, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot(32.1, Mean_MeanDopaBetaHydrox_NeuNRFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2)
plot(32.2, Mean_MeanDopaBetaHydrox_NeuNMFS, 'color', BLACK, 'marker', 's', 'Linewidth', 2) 
plot([31.8; 31.8], [Range_DopaBetaHydrox_NeuNRFF(1); Range_DopaBetaHydrox_NeuNRFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([31.9; 31.9], [Range_DopaBetaHydrox_NeuNMFF(1); Range_DopaBetaHydrox_NeuNMFF(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 
plot([32.1; 32.1], [Range_DopaBetaHydrox_NeuNRFS(1); Range_DopaBetaHydrox_NeuNRFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2)
plot([32.2; 32.2], [Range_DopaBetaHydrox_NeuNMFS(1); Range_DopaBetaHydrox_NeuNMFS(2)], 'color', BLACK, 'linestyle', '-', 'Linewidth', 2) 


%}

%helps to check where effect sizes are: for i =1:246
%    [d(i).effectVal, i]
%end
%
%for i = 1:length(d)
%   isnan(d(i).effectval)
%end


%parser concept:for i = 1:length(b)
%for c  = 1:length(b(i).names)
%if b(i).names(c) == "MWM"
%b(i).nameCat(c) = 1; elseif b(i).names(c) == "BM", b(i).nameCat(c) = 2, else b(i).nameCat(c) = 0;
%end
%end
%end