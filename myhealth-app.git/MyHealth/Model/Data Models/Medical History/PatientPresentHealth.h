//
//  PatientPresentHealth.h
//  MyHealth
//
//  Created by Ashish Chhabra on 13/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "JSONModel.h"

@interface PatientPresentHealth : JSONModel

@property (nonatomic, retain) NSString *householdContactWAWT;
@property (nonatomic, retain) NSString *tuberculosisOrPositveTBT;
@property (nonatomic, retain) NSString *bloodInSputumOWC;
@property (nonatomic, retain) NSString *excessiveBleedingAfterIODW;
@property (nonatomic, retain) NSString *suicideAttemptOPS;
@property (nonatomic, retain) NSString *wearCorrectiveLenses;
@property (nonatomic, retain) NSString *eyeSurgeryTCVLVIEEWAHA;
@property (nonatomic, retain) NSString *StutterOrStammer;
@property (nonatomic, retain) NSString *wearABraceOrBackSSF;
@property (nonatomic, retain) NSString *rheumaticFever;
@property (nonatomic, retain) NSString *swollenOrPainfullJFOSHDOFSET;
@property (nonatomic, retain) NSString *hearingLoss;
@property (nonatomic, retain) NSString *recurrentEarICOFCSTOGTS;
@property (nonatomic, retain) NSString *hayFeverOrARHI;
@property (nonatomic, retain) NSString *asthma;
@property (nonatomic, retain) NSString *shortnessOfBreath;
@property (nonatomic, retain) NSString *boneJointOrOtherD;
@property (nonatomic, retain) NSString *painOrPressureInChest;
@property (nonatomic, retain) NSString *lossOfFingerOrToe;
@property (nonatomic, retain) NSString *chronicCough;
@property (nonatomic, retain) NSString *painfullOrTrickSOE;
@property (nonatomic, retain) NSString *palpitationOrPoundingH;
@property (nonatomic, retain) NSString *heartTrouble;
@property (nonatomic, retain) NSString *recurrentBackPainOABI;
@property (nonatomic, retain) NSString *highOrLowBloodPressure;
@property (nonatomic, retain) NSString *crampsInYourLegs;
@property (nonatomic, retain) NSString *trickOrLockedKnee;
@property (nonatomic, retain) NSString *frequentIndigestion;
@property (nonatomic, retain) NSString *footTrouble;
@property (nonatomic, retain) NSString *stomachLiverOrIntestinalT;
@property (nonatomic, retain) NSString *NerveInjury;
@property (nonatomic, retain) NSString *gallBladder;
@property (nonatomic, retain) NSString *paralysis;
@property (nonatomic, retain) NSString *epilepsyOrSeizure;
@property (nonatomic, retain) NSString *jaundiceOrhepatitis;
@property (nonatomic, retain) NSString *carTrainSeaAirSickness;
@property (nonatomic, retain) NSString *brokenBones;
@property (nonatomic, retain) NSString *frequentTroubleSleeping;
@property (nonatomic, retain) NSString *adverseReactionToM;
@property (nonatomic, retain) NSString *depressionOfExcessiveWorry;
@property (nonatomic, retain) NSString *skinDiseases;
@property (nonatomic, retain) NSString *lossOfmemoryOrAmnesia;
@property (nonatomic, retain) NSString *tumorGrowthCystCancer;
@property (nonatomic, retain) NSString *nervousTroubleOfAnySort;
@property (nonatomic, retain) NSString *hernia;
@property (nonatomic, retain) NSString *periodsOfUnconsciousness;
@property (nonatomic, retain) NSString *hemorrhoidsOrRectalD;
@property (nonatomic, retain) NSString *parentSiblingWDCSOHD;
@property (nonatomic, retain) NSString *frequantOrpainfulUrination;
@property (nonatomic, retain) NSString *bedWettingSinceAge12;
@property (nonatomic, retain) NSString *xrayOrOtherRadiantionT;
@property (nonatomic, retain) NSString *kidneyStoneOrBloodIU;
@property (nonatomic, retain) NSString *chemotherapy;
@property (nonatomic, retain) NSString *sugarOrAlbuminIU;
@property (nonatomic, retain) NSString *asbestorsOrToxicCE;
@property (nonatomic, retain) NSString *sexuallyTransmittedD;
@property (nonatomic, retain) NSString *recentGainOrLossW;
@property (nonatomic, retain) NSString *platePinOrRodIAB;
@property (nonatomic, retain) NSString *eatingDiscover;

@property (nonatomic, retain) NSString *beenToldToCDOCFAU;
@property (nonatomic, retain) NSString *arthritisRHBU;
@property (nonatomic, retain) NSString *usedIllegalSubstances;
@property (nonatomic, retain) NSString *thyroidTrouble;
@property (nonatomic, retain) NSString *usedTobacoo;
@property (nonatomic, retain) NSString *treatedFFemaleDisorder;
@property (nonatomic, retain) NSString *changeInMenstrualP;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *patientID;
@property (nonatomic, retain) NSMutableArray *patientPresentHealthArray;

+(PatientPresentHealth*)fromDictionary:(NSDictionary*)dictionary;
@end
