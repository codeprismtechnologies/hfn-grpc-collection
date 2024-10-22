npm install fs axios dotenv
if [ "$1" == "dev" ]; then
  echo Environment: "Development" and branch "$2"
else
  echo Environment: "QA" and branch "master"
fi
rm -rf protos
rm -rf temp
mkdir temp
mkdir protos
cd temp
git clone https://github.com/HeartfulnessInstitute/heartintune-common
if [ "$1" == "dev" ]; then
    cd heartintune-common
    git switch $2
    cd ..
fi
cp -r heartintune-common/heartintune-common-api/src/main/proto/* ../protos
git clone https://github.com/HeartfulnessInstitute/heartintune-profile-service.git
if [ "$1" == "dev" ]; then
    cd heartintune-profile-service
    git switch $2
    cd ..
fi
cp -R heartintune-profile-service/heartintune-profile-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/gamification-service.git
if [ "$1" == "dev" ]; then
    cd gamification-service
    git switch $2
    cd ..
fi
cp -r gamification-service/gamification-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/guided-meditation-service.git
if [ "$1" == "dev" ]; then
    cd guided-meditation-service
    git switch $2
    cd ..
fi
cp -r guided-meditation-service/guided-meditation-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/live-meditation-service.git
if [ "$1" == "dev" ]; then
    cd live-meditation-service
    git switch $2
    cd ..
fi
cp -r live-meditation-service/live-meditation-api/src/main/proto/ ../protos
git clone https://github.com/HeartfulnessInstitute/hfn-events-service
if [ "$1" == "dev" ]; then
    cd hfn-events-service
    git switch $2
    cd ..
fi
cp -r hfn-events-service/hfn-events-api/src/main/proto/ ../protos
cd ..
rm -rf temp
