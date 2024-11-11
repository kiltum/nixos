#!/etc/profiles/per-user/kiltum/bin/bash
export PATH=/run/current-system/sw/bin/:$PATH
cd
USER="kiltum"
TAG="daily"
SERVER="restic.tygh.ru"
EXCLUDE="/home/${USER}/.config/restic/exclude"

echo "Check availability for ${SERVER}..."
while ! ping -c 1 -n -w 1 ${SERVER} &> /dev/null
do
    echo "${SERVER} not responding ..."
    sleep 1
done

echo "${SERVER} is online"

if [[ $(date +%u) -gt 6 ]]; then
    TAG="weekly"
    EXCLUDE="/home/${USER}/.config/restic/exclude_weekly"
fi

ionice -c2 nice -n19 restic --verbose backup \
    --compression max \
    --exclude-caches \
    --one-file-system \
    --cleanup-cache \
    --tag ${TAG} \
    --exclude-file=${EXCLUDE} \
    ~
