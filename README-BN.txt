Flow Tube iOS upgrade patch

এটি rakiibull/Flow_ios-এর বিদ্যমান SwiftUI starter-এর জন্য একটি প্রথম iOS UI/feature foundation patch। এটি Android মূল অ্যাপের সম্পূর্ণ 1:1 port নয়; Home feed shell, search, player, saved/history এবং অনুমোদিত direct media URL download foundation দেয়।

ব্যবহার:
1) ZIP extract করুন।
2) প্রতিটি .swift ফাইল GitHub repository rakiibull/Flow_ios-এর একই নামের ফাইল দিয়ে replace করুন।
3) GitHub Actions থেকে Build iOS App চালান।

গুরুত্বপূর্ণ:
- এটি simulator build; সরাসরি iPhone-এ install করার signed IPA নয়।
- Download শুধু সরাসরি downloadable URL এবং আপনার ব্যবহারের অধিকার আছে এমন media-র জন্য। YouTube/অন্যান্য প্ল্যাটফর্মের DRM বা download restriction bypass করে না।
- মূল Android Flow repository-এর কোড কপি করা হয়নি; এটি স্বতন্ত্র SwiftUI implementation foundation।
