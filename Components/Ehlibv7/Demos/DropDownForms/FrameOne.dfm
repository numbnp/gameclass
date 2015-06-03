object frFrameOne: TfrFrameOne
  Left = 0
  Top = 0
  Width = 435
  Height = 266
  Align = alClient
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      435
      50)
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 435
      Height = 50
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label1: TLabel
      Left = 41
      Top = 7
      Width = 73
      Height = 23
      Caption = 'Demo 1'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Memo1: TMemo
      Left = 120
      Top = 8
      Width = 439
      Height = 42
      Anchors = [akLeft, akTop, akRight, akBottom]
      BorderStyle = bsNone
      Lines.Strings = (
        'Using DropDownForms.'
        'Method 1.')
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
      WordWrap = False
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 50
    Width = 435
    Height = 216
    Align = alClient
    ColumnDefValues.AlwaysShowEditButton = True
    DataSource = DataSource1
    DrawGraphicData = True
    DrawMemoText = True
    DynProps = <>
    Flat = True
    IndicatorOptions = [gioShowRowIndicatorEh]
    RowHeight = 2
    RowLines = 2
    TabOrder = 1
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'SpeciesId'
        Footers = <>
        Width = 41
      end
      item
        AlwaysShowEditButton = False
        DynProps = <>
        DropDownFormParams.DropDownFormClassName = 'TDropDownMemoEdit'
        DropDownFormParams.PassParams = pspFieldValueEh
        EditButtons = <>
        FieldName = 'Category'
        Footers = <>
        ReadOnly = True
        Width = 82
      end
      item
        DynProps = <>
        DropDownFormParams.Align = daLeft
        DropDownFormParams.PassParams = pspFieldValueEh
        EditButtons = <>
        FieldName = 'Common_name'
        Footers = <>
        Width = 96
      end
      item
        DynProps = <>
        DropDownFormParams.DropDownForm = DropDownMemoEdit1.Owner
        DropDownFormParams.PassParams = pspFieldValueEh
        DropDownFormParams.AssignBackFieldNames = 'Species_Name'
        EditButtons = <>
        FieldName = 'Species_Name'
        Footers = <>
        Width = 96
      end
      item
        AlwaysShowEditButton = False
        DynProps = <>
        DropDownFormParams.DropDownFormClassName = 'TDropDownMemoEdit'
        DropDownFormParams.PassParams = pspFieldValueEh
        EditButtons = <>
        FieldName = 'Length'
        Footers = <>
        Width = 42
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object MemTableEh1: TMemTableEh
    Active = True
    Params = <>
    Left = 248
    Top = 232
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object SpeciesId: TMTNumericDataFieldEh
          FieldName = 'SpeciesId'
          NumericDataType = fdtAutoIncEh
          AutoIncrement = False
          DisplayLabel = 'SpeciesId'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Category: TMTStringDataFieldEh
          FieldName = 'Category'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Category'
          DisplayWidth = 50
          Size = 50
          Transliterate = True
        end
        object Common_name: TMTStringDataFieldEh
          FieldName = 'Common_name'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Common_name'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object Species_Name: TMTStringDataFieldEh
          FieldName = 'Species_Name'
          StringDataType = fdtWideStringEh
          DisplayLabel = 'Species_Name'
          DisplayWidth = 255
          Size = 255
          Transliterate = True
        end
        object Length: TMTNumericDataFieldEh
          FieldName = 'Length'
          NumericDataType = fdtFloatEh
          AutoIncrement = False
          DisplayLabel = 'Length'
          DisplayWidth = 10
          currency = False
          Precision = 15
        end
        object Notes: TMTBlobDataFieldEh
          FieldName = 'Notes'
          DisplayLabel = 'Notes'
          DisplayWidth = 10
          BlobType = ftMemo
          GraphicHeader = True
          Transliterate = True
        end
      end
      object RecordsList: TRecordsListEh
        Data = (
          (
            2
            'Triggerfish'
            'Clown Triggerfish'
            'Ballistoides conspicillum'
            50.000000000000000000
            
              'Also known as the big spotted triggerfish.  Inhabits outer reef ' +
              'areas and feeds upon crustaceans and mollusks by crushing them w' +
              'ith powerful teeth.  They are voracious eaters, and divers repor' +
              't seeing the clown triggerfish devour beds of pearl oysters.'#10#10'Do' +
              ' not eat this fish.  According to an 1878 account, "the poisonou' +
              's flesh acts primarily upon the nervous tissue of the stomach, o' +
              'ccasioning violent spasms of that organ, and shortly afterwards ' +
              'all the muscles of the body.  The frame becomes rocked with spas' +
              'ms, the tongue thickened, the eye fixed, the breathing laborious' +
              ', and the patient expires in a paroxysm of extreme suffering."'#10#10 +
              'Not edible.'#10#10'Range is Indo-Pacific and East Africa to Somoa.'#10)
          (
            3
            'Snapper'
            'Red Emperor'
            'Lutjanus sebae'
            60.000000000000000000
            
              'Called seaperch in Australia.  Inhabits the areas around lagoon ' +
              'coral reefs and sandy bottoms.'#10#10'The red emperor is a valuable fo' +
              'od fish and considered a great sporting fish that fights with fu' +
              'ry when hooked.  The flesh of an old fish is just as tender to e' +
              'at as that of the very young.'#10#10'Range is from the Indo-Pacific to' +
              ' East Africa.'#10)
          (
            10
            'Wrasse'
            'Giant Maori Wrasse'
            'Cheilinus undulatus'
            229.000000000000000000
            
              'This is the largest of all the wrasse.  It is found in dense ree' +
              'f areas, feeding on a wide variety of mollusks, fishes, sea urch' +
              'ins, crustaceans, and other invertebrates. In spite of its immen' +
              'se size, divers find it a very wary fish.'#10#10'Edibility is consider' +
              'ed poor.'#10#10'Range is the Indo-Pacific and the Red Sea.'#10)
          (
            11
            'Angelfish'
            'Blue Angelfish'
            'Pomacanthus nauarchus'
            30.000000000000000000
            
              'Habitat is around boulders, caves, coral ledges and crevices in ' +
              'shallow waters.  Swims alone or in groups.'#10#10'Its color changes dr' +
              'amatically from juvenile to adult.  The mature adult fish can st' +
              'artle divers by producing a powerful drumming or thumping sound ' +
              'intended to warn off predators.'#10#10'Edibility is good.'#10#10'Range is th' +
              'e entire Indo-Pacific region.'#10)
          (
            12
            'Cod'
            'Lunartail Rockcod'
            'Variola louti'
            80.000000000000000000
            
              'Also known as the coronation trout.  It is found around coral re' +
              'efs from shallow to very deep waters.  Feeds primarily on small ' +
              'fishes.'#10#10'Although this rockcod is considered a good game and foo' +
              'd fish, the large ones may contain a toxin and should not be eat' +
              'en.  There is no way to discern whether the fish contains toxin.' +
              #10#10'Range is the Indo-Pacific and the Red Sea.'#10)
          (
            13
            'Scorpionfish'
            'Firefish'
            'Pterois volitans'
            38.000000000000000000
            
              'Also known as the turkeyfish.  Inhabits reef caves and crevices.' +
              '  The firefish is usually stationary during the day, but feeds a' +
              'ctively at night.  Favorite foods are crustaceans.'#10#10'The dorsal s' +
              'pines of the firefish are needle-like and contain venom.  They c' +
              'an inflict an extremely painful wound.'#10#10'Edibility is poor.'#10#10'Rang' +
              'e is from Western Australia to Malaysia.'#10#10)
          (
            14
            'Butterflyfish'
            'Ornate Butterflyfish'
            'Chaetodon Ornatissimus'
            19.000000000000000000
            
              'Normally seen in pairs around dense coral areas from very shallo' +
              'w to moderate depths.  The butterflyfish feeds mainly on coral p' +
              'olyps and anemones.'#10#10'Edibility is poor.'#10#10'Range is Indo-Pacific f' +
              'rom Sri Lanka to Polynesia.'#10)
          (
            15
            'Shark'
            'Swell Shark'
            'Cephaloscyllium ventriosum'
            102.000000000000000000
            
              'Inhabits shallow reef caves and crevices and kelp beds along the' +
              ' coast and offshore islands.  This shark feeds at night on fishe' +
              's and crustaceans and is totally harmless to divers.'#10#10'For defens' +
              'e, the swell shark inflates its stomach with water to tightly lo' +
              'dge itself in a reef crevice.  '#10#10'Edibility is poor.'#10#10'Range is fr' +
              'om Monterey Bay to Acapulco.  Also found in Chile.'#10)
          (
            16
            'Ray'
            'Bat Ray'
            'Myliobatis californica'
            56.000000000000000000
            
              'Also know as the grinder ray because of its flat grinding teeth ' +
              'used to crush its meal of crustaceans or invertebrates.  Inhabit' +
              's bays, sloughs, and kelp beds with sandy bottoms.'#10#10'The bat ray ' +
              'digs up food with its wings and snout, and will even bite off ov' +
              'erhanging ledges to get at prey.  It hunts singly or in groups. ' +
              ' When resting, it buries itself in sand with just the eyes protr' +
              'uding.'#10#10'Edibility is poor.'#10#10'Range is from Oregon to the Gulf of ' +
              'California.'#10)
          (
            17
            'Eel'
            'California Moray'
            'Gymnothorax mordax'
            150.000000000000000000
            
              'This fish hides in a shallow-water lair with just its head protr' +
              'uding during the day.  At night it feeds on octopuses, crustacea' +
              'ns, and small fish close by.'#10#10'If caught, it will bite anything n' +
              'earby with its large fang-like teeth.  Divers can be bitten by a' +
              ' moray eel when sticking their hands into crevices or holes in s' +
              'earch of lobster or abalone.'#10#10'Edibility is good.'#10#10'Range is from ' +
              'Southern California to Southern Baja.')
          (
            18
            'Cod'
            'Lingcod'
            'Ophiodon elongatus'
            150.000000000000000000
            
              'Widely found from near the shore to very deep waters.  Young fis' +
              'h stay on sand or mud bottoms of bays and inshore areas.  The li' +
              'ngcod is a voracious predator, eating many different fishes and ' +
              'octopuses.'#10#10'This fish changes color when stressed.  The flesh co' +
              'lor also changes, from a greenish hue when caught to white when ' +
              'cooked.'#10#10'Edibility is good; Lingcod is a popular sport and comme' +
              'rcial fish.'#10#10'Range is Alaska to Northern Baja California.')
          (
            19
            'Sculpin'
            'Cabezon'
            'Scorpaenichthys marmoratus'
            99.000000000000000000
            
              'Often called the great marbled sculpin.  Found over rocky or she' +
              'll-encrusted bottoms from shallow to moderately deep waters.  It' +
              ' feeds primarily on crustaceans and mollusks.'#10#10'The male cabezon ' +
              'will not budge while guarding its nest and can even be touched b' +
              'y divers.'#10#10'Edibility is good; the flesh is bluish-green but turn' +
              's white when cooked.  The eggs of the cabezon are poisonous.'#10#10'Ra' +
              'nge is from Alaska to Central Baja.'#10)
          (
            20
            'Spadefish'
            'Atlantic Spadefish'
            'Chaetodiperus faber'
            90.000000000000000000
            
              'Found in mid-water areas around reefs, wrecks and bridges.  The ' +
              'tiny, all-black juveniles drift motionless in the shallows, look' +
              'ing like leaves and pods of mangrove.'#10#10'Edibility is good.'#10#10'Range' +
              ' is Bermuda, New England to Brazil, and the Gulf of Mexico.'#10#10)
          (
            21
            'Shark'
            'Nurse Shark'
            'Ginglymostoma cirratum'
            400.000000000000000000
            
              'Frequently found under rock or reef ledges.  Carnivorous with we' +
              'll-developed organs for scent and vibration detection.'#10#10'Like all' +
              ' sharks, the nurse shark has a skeleton of cartilage rather than' +
              ' bone.  Instead of scales, its body is covered with tiny razor-s' +
              'harp denticles.  The teeth are specialized forms of denticles.  ' +
              'Sharks must continually swim or will slowly sink because they ha' +
              've no air bladder.'#10#10'Edibility is poor.'#10#10'Range is from Rhode Isla' +
              'nd to Brazil, including the Gulf of Mexico.'#10)
          (
            22
            'Ray'
            'Spotted Eagle Ray'
            'Aetobatus narinari'
            200.000000000000000000
            
              'Found in reef areas and sandy bottoms.  The spotted eagle ray ha' +
              's a poisonous spine on its tail and incredibly powerful jaws to ' +
              'crush oysters, clams, and numerous crustaceans.  Divers report l' +
              'arge schools during breeding season.'#10#10'This ray is an active swim' +
              'mer and often leaps into the air.  The slapping sound it makes o' +
              'n the water is thought to mark a territory.'#10#10'Edibility is poor.'#10 +
              #10'Range is throughout the tropics.'#10)
          (
            23
            'Snapper'
            'Yellowtail Snapper'
            'Ocyurus chrysurus'
            75.000000000000000000
            
              'Prefers to congregate in loose groups in the open water above re' +
              'ef areas.  Has well-developed teeth and usually feeds at night o' +
              'n small fishes, crustaceans, and plankton.'#10#10'The yellowtail snapp' +
              'er repeatedly snaps its jaws after it has been caught.  Divers h' +
              'ave been injured by these fish.'#10#10'This is an excellent game fish ' +
              'with tenacious fighting ability and tasty flesh.'#10#10'Range is Bermu' +
              'da, New England to Brazil, and the Gulf of Mexico.'#10)
          (
            24
            'Parrotfish'
            'Redband Parrotfish'
            'Sparisoma Aurofrenatum'
            28.000000000000000000
            
              'Inhabits reef areas.  The parrotfish'#39's teeth are fused together,' +
              ' enabling them to scrape away hard coral outer skeletons to get ' +
              'at polyps inside.  These fish are thought to be a major factor i' +
              'n reef recycling.'#10#10'Occasionally a female will change sex, increa' +
              'se in size, and take on a distinct appearance  as a terminal-pha' +
              'se male.  This is usually done to replace a missing male.'#10#10'Edibi' +
              'lity is poor. '#10#10'Range is Bermuda and Florida to Brazil.'#10#10)
          (
            25
            'Barracuda'
            'Great Barracuda'
            'Sphyraena barracuda'
            150.000000000000000000
            
              'Young barracuda live in inshore seagrass beds, while adults rang' +
              'e from inshore channels to the open ocean.  The barracuda feeds ' +
              'on a wide variety of fishes.'#10#10'It frequently drifts just below th' +
              'e surface and is known to approach divers at very close range.  ' +
              'The long underslung jaw with its very sharp teeth can be disconc' +
              'erting.  Attacks on humans have reportedly been in cloudy water ' +
              'when the victim is wearing bright diving gear or attempting to s' +
              'pear the fish.'#10#10'Edibility is good for small specimens, but  larg' +
              'e barracuda can carry a fatal toxin.  There is no visible way to' +
              ' tell if the fish is harmful to eat.'#10#10'Range is worldwide.'#10)
          (
            26
            'Grunt'
            'French Grunt'
            'Haemulon flavolineatum'
            30.000000000000000000
            
              'The French grunt drifts in large groups in sheltered reef areas ' +
              'during the day.  It forages nearby for other fish at night.'#10#10'The' +
              ' fish produces a grunt-like sound by grinding teeth located in t' +
              'he throat.  The sound is amplified by the adjacent swim bladder.' +
              '  During territorial skirmishes, male grunts will face and push ' +
              'each other with open mouths.'#10#10'Edibility is excellent.'#10#10'Range is ' +
              'Bermuda, South Carolina to Brazil, and the Gulf of Mexico.'#10)
          (
            27
            'Snapper'
            'Dog Snapper'
            'Lutjanus jocu'
            90.000000000000000000
            
              'This fish is named for its elongated canine teeth at the front o' +
              'f the upper jaw.  It is solitary and wary and stays in the deep ' +
              'reef or submerged wreck areas.  Not very common anywhere.'#10#10'Edibi' +
              'lity is good if the fish is small.  However, a large dog snapper' +
              ' may contain a fatal toxin.  These fish repeatedly snap their ja' +
              'ws shut after removal from a hook or net.'#10#10'Range is New England ' +
              'to Brazil and the Gulf of Mexico.'#10)
          (
            28
            'Grouper'
            'Nassau Grouper'
            'Epinephelus striatus'
            91.000000000000000000
            
              'Found around shallow coral reefs and seagrass beds, feeding main' +
              'ly on fishes.'#10#10'This is the most friendly of all groupers.  If of' +
              'fered food, it will return again and again, looking for more. '#10#10 +
              'As a defense, the Nassau grouper can change colors to blend perf' +
              'ectly into any background, from white to solid black.'#10#10'Range is ' +
              'Bermuda, North Carolina to Brazil, and the Gulf of Mexico.')
          (
            29
            'Wrasse'
            'Bluehead Wrasse'
            'Thalassoma bifasciatum'
            15.000000000000000000
            
              'Found in coral reefs, rocky flats, reef sand, and seagrass habit' +
              'ats.  This is one of the most successful "cleaner fish" in the t' +
              'ropical West Atlantic.  It feeds on the parasites of other fish,' +
              ' who come to the wrasse to be cleaned.'#10#10'Most bluehead wrasses ar' +
              'e yellow.  The head of the terminal-phase male (about 4% of the ' +
              'population) is blue.'#10#10'Edibility is poor.'#10#10'Range is large, includ' +
              'ing both sides of the Atlantic, Bermuda, Bahamas, and Florida to' +
              ' Curacao, plus the Gulf of Mexico.')
          (
            30
            'Jack'
            'Yellow Jack'
            'Gnathanodon speciousus'
            90.000000000000000000
            
              'Inhabits reef and mid-water areas, feeding on invertebrates and ' +
              'small fishes.  The adult is one of the few jacks without teeth.'#10 +
              #10'The young fish seek out larger predators, such as sharks, for p' +
              'rotection.  Divers have reported young jacks wanting to join up ' +
              'with them!'#10#10'Edibility is excellent.'#10#10'Range is Indo-Pacific and S' +
              'outhern California to Panama.'#10)
          (
            31
            'Surfperch'
            'Redtail Surfperch'
            'Amphistichus rhodoterus'
            40.000000000000000000
            
              'Inhabits exposed sandy shorelines to shallow depths.  Feeds on s' +
              'and-dwelling crustaceans and mollusks.'#10#10'While almost all other m' +
              'arine fishes fertilize and scatter large numbers of eggs outside' +
              ' the body, the surfperch nourishes offspring inside the ovary an' +
              'd spawns them live and sexually active into the surf.'#10#10'A favorit' +
              'e sport fish for surf anglers.  Edibility is very good.'#10#10'Range i' +
              's from Vancouver Island to Central California.'#10)
          (
            32
            'Croaker'
            'White Sea Bass'
            'Atractoscion nobilis'
            150.000000000000000000
            
              'Schools are found over rocky bottoms and around kelp forest cano' +
              'pies.  Not a true bass, this is the largest of the croakers on t' +
              'he Pacific Coast.  It feeds in mid-water on squid, anchovies, an' +
              'd sardines.  '#10#10'Croakers make a remarkable "boop-boop-boop" sound' +
              ', and submarine commanders discovered they could hide the sound ' +
              'of their engines behind the racket.  '#10#10'The large calcareous "ear' +
              'stones" in this fish'#39's inner ear canals were considered good luc' +
              'k charms by early Europeans and were used by American Indians in' +
              ' jewelry.'#10#10'Excellent edibility if you can find one.  White sea b' +
              'ass were heavily fished in the 1950s but are now rarely caught.'#10 +
              #10'Range is from Alaska to Southern Baja.'#10)
          (
            33
            'Greenling'
            'Rock Greenling'
            'Hexagrammos lagocephalus'
            60.000000000000000000
            
              'Inhabits rocky areas along shallow exposed coast line.'#10#10'Greenlin' +
              'gs can change their color to blend with the surrounding sunlit r' +
              'ock and seaweed.  Their scales are very rough and give the body ' +
              'a sandpaper-like texture.'#10#10'An 1886 description of a greenling co' +
              'mes from naturalist J.K. Lord.  He was overcome by its beauty, a' +
              'nd said "its sides...rival in beauty many a tropical flower...[a' +
              'nd are] adorned with colors not only conspicuous for their brill' +
              'iancy, but grouped and blended in a manner one sees only represe' +
              'nted in the plumage of a bird, the wing of a butterfly, or the p' +
              'etals of an orchid...red, blue, orange, and green are so mingled' +
              ' that the only thing I can think of as a comparison is a floatin' +
              'g flower bed, and even the gardener'#39's art, in grouping, is but a' +
              ' bungle contrasted with nature'#39's painting."'#10#10'Edibility is good.'#10 +
              #10'Range is from the Bering Sea to Southern California.'#10)
          (
            34
            'Wrasse'
            'Senorita'
            'Oxyjulis californica'
            25.000000000000000000
            
              'Found almost everywhere by divers, this fish lives either in sch' +
              'ools or alone.  It is a voracious eater that feeds constantly.  ' +
              'It is also a very successful "cleaner fish", and a single Senori' +
              'ta may be surrounded by dozens of fishes waiting to be cleaned o' +
              'f parasites.  Divers report them teaming up to clean a large sea' +
              ' bass or Mola.'#10#10'This fish does not reverse sex as most wrasses d' +
              'o.  When disturbed, it burrows in the bottom sediment.  It also ' +
              'sleeps there with its head protruding from the sand.'#10#10'Edibility ' +
              'is poor.'#10#10'Range is Northern California to Central Baja. ')
          (
            35
            'Smelt'
            'Surf Smelt'
            'Hypomesus pretiosus'
            25.000000000000000000
            
              'Also called the day smelt because of the timing of its spawning ' +
              'runs.  Inhabits the surf line, feeding on small fishes and inver' +
              'tebrates.  '#10#10'Surf smelt ride a wave onto the beach, lay and fert' +
              'ilize their eggs, and catch a return wave to the sea.  The fry h' +
              'atch approximately two weeks later during high tide. '#10#10'This fish' +
              ' is a favorite among surf anglers.  Edibility is good.'#10#10'Range is' +
              ' from Alaska to Southern California.'))
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    Left = 240
    Top = 224
  end
end
