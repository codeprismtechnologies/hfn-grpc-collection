rm -rf protos
rm -rf temp
mkdir temp
mkdir protos
cd temp
git clone https://github.com/HeartfulnessInstitute/heartintune-common
cp -r heartintune-common/heartintune-common-api/src/main/proto/* ../protos
git clone https://github.com/HeartfulnessInstitute/heartintune-profile-service.git
cp -R heartintune-profile-service/heartintune-profile-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/gamification-service.git
cp -r gamification-service/gamification-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/guided-meditation-service.git
cp -r guided-meditation-service/guided-meditation-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/live-meditation-service.git
cp -r live-meditation-service/live-meditation-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/hfn-events-service
cp -r hfn-events-service/hfn-events-api/src/main/proto/ ../protos
cd ..
rm -rf temp
