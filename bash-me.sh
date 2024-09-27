if [ ! $(gh run list --limit=1 --json status | grep -Eo 'completed') ]; then
  echo "The latest build has failed or is pending!"
  exit 1
fi
if [ ! -d /Volumes/NICENANO ]; then
  echo "Nice nano not in flash mode!"
  exit 1
fi
echo "Downloading firmware..."
gh run download $(gh run list --limit=1 --json databaseId | grep -Eo '[0-9]+')
if [ ! -d ./firmware ]; then
  echo "Failed to download firmware!"
  exit 1
fi
echo "Flashing firmware..."
mv firmware/temper_left-nice_nano_v2-zmk.uf2 /Volumes/NICENANO/
rm -r firmware
echo "Done!"
