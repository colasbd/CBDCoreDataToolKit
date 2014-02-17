//
//  CBDCoreDataDiscriminatorSimilarityStatus.h
//  Pods
//
//  Created by Colas on 13/02/2014.
//
//



typedef NS_ENUM(NSInteger, CBDCoreDataDiscriminatorSimilarityStatus)
{
    CBDCoreDataDiscriminatorSimilarityStatusNoStatus,
    CBDCoreDataDiscriminatorSimilarityStatusIsSimilar,
    CBDCoreDataDiscriminatorSimilarityStatusIsQuasiSimilar,
    CBDCoreDataDiscriminatorSimilarityStatusIsNotSimilar,
    CBDCoreDataDiscriminatorSimilarityStatusIsChecking,
    CBDCoreDataDiscriminatorSimilarityStatusInvalidStatus,
    CBDCoreDataDiscriminatorSimilarityStatusCount
};



