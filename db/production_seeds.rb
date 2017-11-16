require_relative "../app/helpers/insurance_data_helper"

class ProductionSeed

  def self.seed_tags
    # CREATE DEFAULT TAGS

    safe = ["transgender", "non-binary", "queer", "genderqueer", "trans masculine", "trans feminine", "polyamorous", "asexual", "gay", "lesbian", "bisexual", "pansexual", "latinx", "american indian", "asian", "black", "african american", "middle eastern", "multiracial", "intersex", "a person of color", "female", "male", "two-spirit"]

    competencies = ["sex workers", "youth", "teen", "adult", "blind or visually impaired", "deaf or hard hearing", "hiv positive",  "other abled", "cognitive disability", "developmental disability","mental health", "in recovery", "survivors of abuse or trauma", "undocumented", "uninsured", "experiencing addiction", "experiencing homelessness",  "veterans"]

    actions = ["asked for pronouns", "used my preferred name", "used my preferred pronouns", "was body positive", "was sex positive", "was fat positive", "respected my partner(s)", "was familiar with my medical concerns", "listened actively", "did not make harmful assumptions", "was up-to-date with current research", "avoided perpetuating stereotypes"]

    services = ["hormone therapy", "fertility", "top surgery", "lower surgery", "ffs", "fms", "clitoroplasty", "body sculpting", "breast augmentation", "buttock augmentation", "glansplasty", "hair grafting", "hysterectomy", "labiaplasty", "metoidioplasty", "orchiectomy", "penile implant", "phalloplasty", "scrotoplasty", "tracheal shave", "urethroplasty", "vaginectomy", "vaginoplasty", "reconstructive urology", "cognitive behavioral therapy", "neuro feedback", "acupuncture", "ivf", "endocrinology", "testesterone therapy", "speech therapy", "mental health", "counseling","transition counseling"]

    safe.each do |tag|
      Tag.create!(description: tag, default: true, category: "safe")
    end

    competencies.each do |tag|
      Tag.create(description: tag, default: true, category: "competencies")
    end

    actions.each do |tag|
      Tag.create(description: tag, default: true, category: "actions")
    end

    services.each do |tag|
      Tag.create(description: tag, default: true, category: "services")
    end

    puts "Tags have been seeded"
  end

  def self.superadmin(username, password)
    user = User.find_by(username: username)
    user.password = password
    user.superadmin = true
    user.admin = true
    user.save!
    puts "#{username} is now a superadmin"
  end

  def self.seed_insurance
    insurances = ["Advantage Health Solutions", "Aetna", "Altius Coventry Health Care", "Ambetter Superior Health Plan", "Amerihealth", "Ameritas", "Anthem", "Assurant", "Aultcare", "BCBS Blue Card", "BCBS Minnesota", "Blue Cross Blue Sheild of Alabama", "Blue Cross Blue Shield of Aritona", "Blue Cross Blue Shield of Florida", "Blue Cross Blue Shield of Florida BCBSFL", "Blue Cross Blue Shield of Georgia", "Blue Cross Blue Shield of Illinois", "Blue Cross Blue Shield of Kansas City", "Blue Cross Blue Shield of Louisiana", "Blue Cross Blue Shield of Massachusetts", "Blue Cross Blue Shield of Michigan", "Blue Cross Blue Shield of New Mexico", "Blue Cross Blue Shield of Oklahoma", "Blue Cross Blue Shield of Rhode Island", "Blue Cross Blue Shield of TX", "Blue Cross Blue Shield of Tennessee", "Blue Cross Blue Shield of Texas", "Blue Cross Blue Shield of Texas BCBSTX", "Blue Cross Blue Shield of Wyoming", "Blue Cross Idaho", "Blue Shield of California", "Bluegrass Family Health", "Bridgespan", "Buckeye Community Health Plan", "Capital Blue Cross", "Capital District Physicians Health Plan", "Care First Blue Cross Blue Shield", "Chinese Community Health Plan", "Cigna", "Cigna Dental", "Cofinity", "CommUnityCare Health Centers", "CompBenefits Corporation", "Connecticare", "Coventry Health Care", "Delta Dental", "Dental Network of America", "DenteMax", "Diversified Dental", "Dominion Group", "Emblem Health", "Empire BCBS", "Excellus BCBS", "First Choice", "First Dental Health", "First Health Coventry Healthcare", "GWH-Cigna", "Geisinger Health Plan", "Group Health Cooperative", "Guardian Dental", "Gundersen Health Plan", "HAP", "HIP of NY", "HMSA", "Harvard Pilgrim", "Health Alliance", "Health Net", "Health Plan of Nevada", "HealthFirst NY", "HealthLink", "HealthNow", "HealthPlus of Michigan", "HealthSpan", "Highmark Blue Cross Blue Shield", "Home State Health Plan", "Horizon BCBS", "Humana", "IBC  Amerihealth", "Independence Blue Cross", "Independent Health Association", "Kaiser - MidAtlantic", "Kaiser Permanente", "L.A. Care Health", "Liberty Dental Plan", "Lifewise health Plan of Oregon", "MHS Indiana", "MHealth Insured", "MVP Health Plan", "MagnaCare", "Medicaid", "Medical Mutual of Ohio", "Medicare", "MetLife", "Molina Healthcare", "Multiplan", "ODS Health Plan", "Oxford Health", "PacificSource Health Plans", "Paramount", "Premera Blue Cross", "Premera Blue Cross Blue Shield", "Presbyterian Healthcare Services", "Principal Financial Services", "PriorityHealth", "Providence Health System", "QualCare", "Qualchoice", "Regence Blue Cross Blue Shield of Oregon", "Regence Blue Cross Blue Shield of Utah", "Regence Blue Shield of Idaho", "Regence Blue Shield of Washington", "Rocky Mountain Health Plans", "Sagamore Health Network", "Scion Dental", "Scott and White", "Sharp Health Plan", "Sierra Health", "Spectrum Health", "Total Dental Administrators", "Total Health Plan", "Tufts Health Plan", "UHC West Formerly Pacificare", "UHC of the River Valley", "United Concordia", "United Healthcare", "United Healthcare Dental", "Unity Health Insurance", "VSP", "Wellmark Blue Cross and Blue Shield", "Western Health Advantage", "Wisconsin Physicians Service Insurance Corporation"]
    insurances.each do |insurance|
      Insurance.create(insurance_name: insurance)
    end
  end

  def self.seed_anon_user
    User.create(username: "anonymous", password: "1234!@#AAbb", email: "anon_user@aol.com", admin: false, superadmin: false)
  end

  def self.seed_doctors
    doc1 = Doctor.create(first_name: 'Katherine', last_name: "Nash", city: "Chicago", state: "IL", zipcode: "60611", street: "676 N St Clair St", specialty: "OBGYN", gender: "female", phone_number: "3125733700", website: "http://www.pc4w.com/womens-care-practitioners-chicago/kate-nash/")

    doc1.insurances << Insurance.find_by(insurance_uid: "aetna")
    doc1.insurances << Insurance.find_by(insurance_uid: "assurant")

    doc1.insurances << Insurance.find_by(insurance_uid: "cigna")

    rec1 = Recommendation.create(user: User.find_by(username: "anonymous"), doctor: doc1, review: "Dr Nash starts her appointments by sitting with her patients and listening intently to their concerns and questions. She shows empathy when patients express concerns and answers kindly to questions when they arise. She always makes your feel like you're her only patient even though she has a long roster. Dr Nash is also willing to give patients valuable and reliable resources and will follow up with you via email with additional information unprompted. She's great and made me feel like a respected human despite my medical history which is a sad but unusual trait to find in the medical industry.")

    rec1.tags << Tag.find_by(description: "female")

    doc2 = Doctor.create(first_name: 'Patricia', last_name: "Lewis", city: "Seattle", state: "WA", zipcode: "98144", street: "1200 12th Ave S", specialty: "Primary Care", gender: "female", phone_number: "2065176700", website: "http://www.pacificmedicalcenters.org/index.php/who-we-are/patricia-lewis")

    doc2.insurances << Insurance.find_by(insurance_uid: "aetna")

    rec2 = Recommendation.create(user: User.find_by(username: "anonymous"), doctor: doc2, review: "Dr. Lewis is a no non-sense physician who cares about her patients. It also helps that she is hilarious, too! ")

    rec2.tags << Tag.find_by(description: "lesbian")

    doc3 = Doctor.create(first_name: 'Gillian', last_name: "Rose", city: "Seattle", state: "WA", zipcode: "98122", street: "1633 Bellevue Ave Suite A", specialty: "Acupuncturist", gender: "female", phone_number: "2066796934", website: "http://www.twelveriversmedicine.com/")

    doc3.insurances << Insurance.find_by(insurance_uid: "aetna")
    doc3.insurances << Insurance.find_by(insurance_uid: "cigna")
    doc3.insurances << Insurance.find_by(insurance_uid: "premerabluecross")


    rec3 = Recommendation.create(user: User.find_by(username: "anonymous"), doctor: doc3, review: "Gillian provides affordable acupuncture treatments complemented by herbal medicine, food therapy and nutrition. Her practice focuses on pain management, anxiety and depression, digestive disorders, recovery from auto injury, chronic and autoimmune disease and health maintenance. ")

    rec3.tags << Tag.find_by(description: "queer")
    rec3.tags << Tag.find_by(description: "transgender")
    rec3.tags << Tag.find_by(description: "non-binary")


    doc4 = Doctor.create(first_name: 'Janna', last_name: "Cuneo", city: "Seattle", state: "WA", zipcode: "98101", street: "1930 Post Alley", specialty: "Primary Care Nurse Practitoner", gender: "female", phone_number: "2067284143", website: "https://www.neighborcare.org/clinics/neighborcare-health-pike-place-market")

    doc4.insurances << Insurance.find_by(insurance_uid: "medicaid")
    doc4.insurances << Insurance.find_by(insurance_uid: "medicare")

    rec4 = Recommendation.create(user: User.find_by(username: "anonymous"), doctor: doc4, review: "Janna is involved as a provider and an advocate for transgender healthcare and hormone therapy.")

    rec4.tags << Tag.find_by(description: "genderqueer")
    rec4.tags << Tag.find_by(description: "transgender")
    rec4.tags << Tag.find_by(description: "non-binary")

    doc5 = Doctor.create(first_name: 'Rachel', last_name: "Pelto", city: "Seattle", state: "WA", zipcode: "98104", street: "1101 Madison St", specialty: "Nurse Practitioner", gender: "female", phone_number: "2063863400", website: "https://www.nwwomenshealth.com/providers/rachel-pelto/")

    doc5.insurances << Insurance.find_by(insurance_uid: "aetna")
    doc5.insurances << Insurance.find_by(insurance_uid: "cigna")
    doc5.insurances << Insurance.find_by(insurance_uid: "multiplan")
    doc5.insurances << Insurance.find_by(insurance_uid: "regencebluecrossblueshieldoforegon")

    rec5 = Recommendation.create(user: User.find_by(username: "anonymous"), doctor: doc5, review: "Rachel Pelto consistently listens to my concerns, and is very empathetic. I feel comfortable bringing all of my medical concerns to her, and feel that she is competent to help me get well.")

    rec5.tags << Tag.find_by(description: "female")
    rec5.tags << Tag.find_by(description: "was sex positive")
    rec5.tags << Tag.find_by(description: "listened actively")

  end

end
