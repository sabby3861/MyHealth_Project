//
//  PatientPresentHealth.m
//  MyHealth
//
//  Created by Ashish Chhabra on 13/11/14.
//  Copyright (c) 2014 Health. All rights reserved.
//

#import "PatientPresentHealth.h"

@implementation PatientPresentHealth
+(PatientPresentHealth*)fromDictionary:(NSDictionary*)dictionary
{
    PatientPresentHealth *patientPresentHealth = [[PatientPresentHealth alloc] init];
    patientPresentHealth.householdContactWAWT=dictionary[@"householdContactWAWT"];
    patientPresentHealth.tuberculosisOrPositveTBT=dictionary[@"tuberculosisOrPositveTBT"];
    patientPresentHealth.bloodInSputumOWC=dictionary[@"bloodInSputumOWC"];
    patientPresentHealth.excessiveBleedingAfterIODW=dictionary[@"excessiveBleedingAfterIODW"];
    patientPresentHealth.suicideAttemptOPS=dictionary[@"suicideAttemptOPS"];
    patientPresentHealth.wearCorrectiveLenses=dictionary[@"wearCorrectiveLenses"];
    patientPresentHealth.eyeSurgeryTCVLVIEEWAHA=dictionary[@"eyeSurgeryTCVLVIEEWAHA"];
    patientPresentHealth.StutterOrStammer=dictionary[@"StutterOrStammer"];
    patientPresentHealth.wearABraceOrBackSSF=dictionary[@"wearABraceOrBackSSF"];
    patientPresentHealth.rheumaticFever=dictionary[@"rheumaticFever"];
    patientPresentHealth.swollenOrPainfullJFOSHDOFSET=dictionary[@"swollenOrPainfullJFOSHDOFSET"];
    patientPresentHealth.hearingLoss=dictionary[@"hearingLoss"];
    patientPresentHealth.recurrentEarICOFCSTOGTS=dictionary[@"recurrentEarICOFCSTOGTS"];
    patientPresentHealth.hayFeverOrARHI=dictionary[@"hayFeverOrARHI"];
    patientPresentHealth.asthma=dictionary[@"asthma"];
    patientPresentHealth.shortnessOfBreath=dictionary[@"shortnessOfBreath"];
    patientPresentHealth.boneJointOrOtherD=dictionary[@"boneJointOrOtherD"];
    patientPresentHealth.painOrPressureInChest=dictionary[@"painOrPressureInChest"];
    patientPresentHealth.lossOfFingerOrToe=dictionary[@"lossOfFingerOrToe"];
    patientPresentHealth.chronicCough=dictionary[@"chronicCough"];
    patientPresentHealth.painfullOrTrickSOE=dictionary[@"painfullOrTrickSOE"];
    patientPresentHealth.palpitationOrPoundingH=dictionary[@"palpitationOrPoundingH"];
    patientPresentHealth.heartTrouble=dictionary[@"heartTrouble"];
    patientPresentHealth.recurrentBackPainOABI=dictionary[@"recurrentBackPainOABI"];
    patientPresentHealth.highOrLowBloodPressure=dictionary[@"highOrLowBloodPressure"];
    patientPresentHealth.crampsInYourLegs=dictionary[@"crampsInYourLegs"];
    patientPresentHealth.trickOrLockedKnee=dictionary[@"trickOrLockedKnee"];
    patientPresentHealth.frequentIndigestion=dictionary[@"frequentIndigestion"];
    patientPresentHealth.footTrouble=dictionary[@"footTrouble"];
    patientPresentHealth.stomachLiverOrIntestinalT=dictionary[@"stomachLiverOrIntestinalT"];
    patientPresentHealth.NerveInjury=dictionary[@"NerveInjury"];
    patientPresentHealth.gallBladder=dictionary[@"gallBladder"];
    patientPresentHealth.paralysis=dictionary[@"paralysis"];
    patientPresentHealth.epilepsyOrSeizure=dictionary[@"epilepsyOrSeizure"];
    patientPresentHealth.jaundiceOrhepatitis=dictionary[@"jaundiceOrhepatitis"];
    patientPresentHealth.carTrainSeaAirSickness=dictionary[@"carTrainSeaAirSickness"];
    patientPresentHealth.brokenBones=dictionary[@"brokenBones"];
    patientPresentHealth.frequentTroubleSleeping=dictionary[@"frequentTroubleSleeping"];
    patientPresentHealth.adverseReactionToM=dictionary[@"adverseReactionToM"];
    patientPresentHealth.depressionOfExcessiveWorry=dictionary[@"depressionOfExcessiveWorry"];
    patientPresentHealth.skinDiseases=dictionary[@"skinDiseases"];
    patientPresentHealth.lossOfmemoryOrAmnesia=dictionary[@"lossOfmemoryOrAmnesia"];
    patientPresentHealth.tumorGrowthCystCancer=dictionary[@"tumorGrowthCystCancer"];
    patientPresentHealth.nervousTroubleOfAnySort=dictionary[@"nervousTroubleOfAnySort"];
    patientPresentHealth.hernia=dictionary[@"hernia"];
    patientPresentHealth.periodsOfUnconsciousness=dictionary[@"periodsOfUnconsciousness"];
    patientPresentHealth.hemorrhoidsOrRectalD=dictionary[@"hemorrhoidsOrRectalD"];
    patientPresentHealth.parentSiblingWDCSOHD=dictionary[@"parentSiblingWDCSOHD"];
    patientPresentHealth.frequantOrpainfulUrination=dictionary[@"frequantOrpainfulUrination"];
    patientPresentHealth.bedWettingSinceAge12=dictionary[@"bedWettingSinceAge12"];
    patientPresentHealth.xrayOrOtherRadiantionT=dictionary[@"xrayOrOtherRadiantionT"];
    patientPresentHealth.kidneyStoneOrBloodIU=dictionary[@"kidneyStoneOrBloodIU"];
    patientPresentHealth.chemotherapy=dictionary[@"chemotherapy"];
    patientPresentHealth.sugarOrAlbuminIU=dictionary[@"sugarOrAlbuminIU"];
    patientPresentHealth.asbestorsOrToxicCE=dictionary[@"asbestorsOrToxicCE"];
    patientPresentHealth.sexuallyTransmittedD=dictionary[@"sexuallyTransmittedD"];
    patientPresentHealth.recentGainOrLossW=dictionary[@"recentGainOrLossW"];
    patientPresentHealth.platePinOrRodIAB=dictionary[@"platePinOrRodIAB"];
    patientPresentHealth.eatingDiscover=dictionary[@"eatingDiscover"];
    patientPresentHealth.beenToldToCDOCFAU=dictionary[@"beenToldToCDOCFAU"];
    patientPresentHealth.arthritisRHBU=dictionary[@"arthritisRHBU"];
    patientPresentHealth.usedIllegalSubstances=dictionary[@"usedIllegalSubstances"];
    patientPresentHealth.thyroidTrouble=dictionary[@"thyroidTrouble"];
    patientPresentHealth.usedTobacoo=dictionary[@"usedTobacoo"];
    patientPresentHealth.treatedFFemaleDisorder=dictionary[@"treatedFFemaleDisorder"];
    patientPresentHealth.changeInMenstrualP=dictionary[@"changeInMenstrualP"];
    patientPresentHealth.date=dictionary[@"date"];
    patientPresentHealth.patientID=dictionary[@"patientID"];
    
    
    patientPresentHealth.patientPresentHealthArray=[[NSMutableArray alloc]init];
    [patientPresentHealth.patientPresentHealthArray addObjectsFromArray:[NSArray arrayWithObjects:
                                                                         patientPresentHealth.householdContactWAWT,
                                                                         patientPresentHealth.tuberculosisOrPositveTBT,patientPresentHealth.bloodInSputumOWC,patientPresentHealth.excessiveBleedingAfterIODW,patientPresentHealth.suicideAttemptOPS,patientPresentHealth.wearCorrectiveLenses,
                                                                         patientPresentHealth.eyeSurgeryTCVLVIEEWAHA, patientPresentHealth.StutterOrStammer,
                                                                         patientPresentHealth.wearABraceOrBackSSF,
                                                                         patientPresentHealth.rheumaticFever,
                                                                         patientPresentHealth.swollenOrPainfullJFOSHDOFSET,
                                                                         patientPresentHealth.hearingLoss,
                                                                         patientPresentHealth.recurrentEarICOFCSTOGTS,
                                                                         patientPresentHealth.hayFeverOrARHI,
                                                                         patientPresentHealth.asthma,
                                                                         patientPresentHealth.shortnessOfBreath,
                                                                         patientPresentHealth.boneJointOrOtherD,
                                                                         patientPresentHealth.painOrPressureInChest,
                                                                         patientPresentHealth.lossOfFingerOrToe,
                                                                         patientPresentHealth.chronicCough,
                                                                         patientPresentHealth.painfullOrTrickSOE,
                                                                         patientPresentHealth.palpitationOrPoundingH,
                                                                         patientPresentHealth.heartTrouble,
                                                                         patientPresentHealth.recurrentBackPainOABI,
                                                                         patientPresentHealth.highOrLowBloodPressure,
                                                                         patientPresentHealth.crampsInYourLegs,
                                                                         patientPresentHealth.trickOrLockedKnee,
                                                                         patientPresentHealth.frequentIndigestion,
                                                                         patientPresentHealth.footTrouble,
                                                                         patientPresentHealth.stomachLiverOrIntestinalT,
                                                                         patientPresentHealth.NerveInjury,
                                                                         patientPresentHealth.gallBladder,
                                                                         patientPresentHealth.paralysis,
                                                                         patientPresentHealth.epilepsyOrSeizure,
                                                                         patientPresentHealth.jaundiceOrhepatitis,patientPresentHealth.carTrainSeaAirSickness,
                                                                         patientPresentHealth.brokenBones,                                                                         patientPresentHealth.frequentTroubleSleeping,
                                                                         patientPresentHealth.adverseReactionToM,
                                                                         patientPresentHealth.depressionOfExcessiveWorry,
                                                                         patientPresentHealth.skinDiseases,
                                                                         patientPresentHealth.lossOfmemoryOrAmnesia,
                                                                         patientPresentHealth.tumorGrowthCystCancer,
                                                                         patientPresentHealth.nervousTroubleOfAnySort,
                                                                         patientPresentHealth.hernia,
                                                                         patientPresentHealth.periodsOfUnconsciousness,
                                                                         patientPresentHealth.hemorrhoidsOrRectalD,
                                                                         patientPresentHealth.parentSiblingWDCSOHD,
                                                                         patientPresentHealth.frequantOrpainfulUrination,
                                                                         patientPresentHealth.bedWettingSinceAge12,
                                                                         patientPresentHealth.xrayOrOtherRadiantionT,
                                                                         patientPresentHealth.kidneyStoneOrBloodIU,
                                                                         patientPresentHealth.chemotherapy,
                                                                         patientPresentHealth.sugarOrAlbuminIU,
                                                                         patientPresentHealth.asbestorsOrToxicCE,patientPresentHealth.sexuallyTransmittedD,
                                                                         patientPresentHealth.recentGainOrLossW,
                                                                         patientPresentHealth.platePinOrRodIAB,
                                                                         patientPresentHealth.eatingDiscover,
                                                                         patientPresentHealth.beenToldToCDOCFAU,
                                                                         patientPresentHealth.arthritisRHBU,
                                                                         patientPresentHealth.usedIllegalSubstances,
                                                                         patientPresentHealth.thyroidTrouble,
                                                                         patientPresentHealth.usedTobacoo,
                                                                         patientPresentHealth.treatedFFemaleDisorder,
                                                                         patientPresentHealth.changeInMenstrualP,
                                                                         patientPresentHealth.date,
                                                                         patientPresentHealth.patientID,
                                                                         nil]];
    return patientPresentHealth;
}
@end
