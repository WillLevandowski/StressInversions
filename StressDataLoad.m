SDR_to_tr_pl


Mechanisms_US=Full_Catalog;
load WSM2016_GVA;GVA=[WSM2016_GVA(:,1:2) WSM2016_GVA(:,4) 45+0*WSM2016_GVA(:,3) -90+WSM2016_GVA(:,3)*0];
load WSM2016_processed
  okay=find(WSM2016_processed(:,4)<360  & WSM2016_processed(:,end)>0.15);WSM2016_processed=WSM2016_processed(okay,:);
WSM2016_processed=[WSM2016_processed;WSM2016_AD_noFMs_Regimes_curated];
foo=find(WSM2016_processed(:,end)<0.2);WSM2016_processed(foo)=0.25;
foo=find(WSM2016_processed(:,end)>1);WSM2016_processed(foo)=1;


 Mechanisms_US=[Mechanisms_US;GVA];
 Locs=Mechanisms_US(:,1:2);

MB=[32.945	-80.13
32.934	-80.148
32.935	-80.167
32.949	-80.152
32.932	-80.14
32.963	-80.178
32.929	-80.158
32.979	-80.218
32.941	-80.146
32.93	-80.155
32.987	-80.152];
for i=1:length(MB)
    foo=find(Locs(:,1)==MB(i,2) & Locs(:,2)==MB(i,1));
    Mechanisms_US(foo,:)=0;
end


clear loc

tic

prov=14;

Mechs_all=Mechanisms_US;
    if prov==1
        name='Gulf of California';
        load NorthernBaja
        load CentralBaja
        load SaltonTrough
        MTs=[NorthernBaja;
       CentralBaja;
       SaltonTrough];
    end
    if prov==2
        name='San Andreas Fault System';
        load SanBernadinoMtns
        load SouthernCalifornia
        load CentralCalifornia
        load SanFran.BayArea
        load BigBend
        load SanGabrielMtns
        load SanJacintoMtns
        load InlandEmpire
        MTs=[SanBernadinoMtns;
            SanGabrielMtns;
            SanJacintoMtns;
            BigBend;
            InlandEmpire;
        SouthernCalifornia
        CentralCalifornia
        SanFran];
    end
    if prov==3
        name='Eastern California Shear Zone';
        load SouthernSierra
        load Inyo-Kern
        load WassukRange
        load CentralBnR
%          CentralBnR=CentralBnR(CentralBnR(:,2)<=39,:);
        load WalkerLane
        load FishLakeValley
        load Mendocino
        load NorthernCalifornia
        MTs=[
            SouthernSierra;
            Inyo_Kern;
        WassukRange;
        CentralBnR;
        WalkerLane;
        FishLakeValley;
        Mendocino;
        NorthernCalifornia];
    end
    if prov==4
        name='Cascadia';
        load CascadianForearc
        load NortheastCascades
        load CascadianBackarc
        load SouthernCascadia
      
        MTs=[CascadianForearc;
        NortheastCascades;
        CascadianBackarc;
        SouthernCascadia;
        ];
    end
    if prov==5
        name='Basin & Range';
        load NorthwestBnR
        load NorthernBnR
        load St.George
        load WasatchFront
        load Tetons
        load Mogul
        MTs=[
        NorthwestBnR;
        NorthernBnR;
        St;
        WasatchFront;
        Tetons;
        Mogul;
        ];
    end
    
    if prov==6
        name='NorthernRockies';
        load Yellowstone
        load NorthernRockies
%         load IdahoBatholith
        MTs=[Yellowstone;
            NorthernRockies];
%             IdahoBatholith];
    end
    if prov==7
        name='Cratonic North America';
        load NorthernColorado
        load NorthCOPlateau
        load SouthCOPlateau
        load NorthernPlains
        load WyomingCraton
       
        MTs=[NorthCOPlateau;
            NorthernColorado;
            SouthCOPlateau;
        NorthernPlains;
        WyomingCraton;
       ];
%          MTs=MTs(MTs(:,1)<-95,:);
          MTs=MTs(MTs(:,2)>35 | MTs(:,1)<-106.5,:);
%           MTs=MTs(MTs(:,2)>40.5 | MTs(:,1)<-105 | MTs(:,1)>-104,:);
          
% NPTF=find(Mechs_all(:,1)==-112.34 & Mechs_all(:,2)==48.52);
% MTs=[MTs;Mechs_all(NPTF,1:3)];
    end
    if prov==8
        name='Southern Plains';
        load SouthernKansas
        load SouthernPlains
      
 
       
        MTs=[SouthernKansas;
        SouthernPlains;
        ];
    okay=find(MTs(:,1)<-99.5 | MTs(:,1)>-96.5 | MTs(:,2)<=37.24);
    MTs=MTs(okay,:);
    
    GulfCoast=find(Mechs_all(:,2)<32.5 & Mechs_all(:,2)>28.75 & Mechs_all(:,1)>min(MTs(:,1)) & Mechs_all(:,1)<-94);
    MTs=[MTs;Mechs_all(GulfCoast,1:3)];
    end
    if prov==9
        name='Midwest';
        load Guy-Greenbrier
        load UpperMississippi
        load OhioRiverValley
      
%           OhioRiverValley=OhioRiverValley(OhioRiverValley(:,1)<-82.01 | OhioRiverValley(:,2)>39,:);
%  
        MTs=[Guy_Greenbrier;
        UpperMississippi;
        OhioRiverValley; 
];
      MTs=MTs(MTs(:,1)>=-97,:);
     load S_ETSZ_poly
%     b=~inpolygon(MTs(:,1),MTs(:,2),S_ETSZ_poly(:,1),S_ETSZ_poly(:,2));
%     MTs=MTs(b,:);
    
    end
    if prov==10
        name='Grenville Terranes';
        load Ottawa
        load OntarioNewYork
        load QuebecCity
        load Gatineau
        load Montreal
        MTs=[OntarioNewYork;
        QuebecCity;
        Gatineau;
        Montreal;
       Ottawa];
    end
    if prov==11
        name='Atlantic Margin';
        load Charlevoix
        load LowerSt.Lawrence
        load NewBrunswick
        load NewEngland
        load Mid-Atlantic
        load CentralVirginia
        load SouthCarolina
        MTs=[LowerSt;
        NewBrunswick;
        Charlevoix
        NewEngland;
        CentralVirginia;
        Mid_Atlantic;
        SouthCarolina];
    end
    if prov==12
        name='Central-Southern Oklahoma';
        load WestCentralOklahoma
        load EastCentralOklahoma
        load NorthernOklahoma1
        load NorthernOklahoma2
%         CentralOklahoma=CentralOklahoma(CentralOklahoma(:,2)>34,:);
        MTs=[WestCentralOklahoma;EastCentralOklahoma;
            NorthernOklahoma1;
            NorthernOklahoma2];
    end
    if prov==13
        name='New Madrid Seismic Zone';
        load NewMadridSouth
        load NewMadridNorth
        load NewMadridCentral
        MTs=[NewMadridNorth;
            NewMadridCentral;
            NewMadridSouth];
    end
    if prov==14
        name='Eastern Tennessee';
        load EasternTennessee
%         load OhioRiverValley
        MTs=[EasternTennessee;
           ];
%         b=inpolygon(MTs(:,1),MTs(:,2),S_ETSZ_poly(:,1),S_ETSZ_poly(:,2));
%         MTs=MTs(b,:);
    end
    if prov==15
        name='Southern Rockies';
        
        load SouthernBnR
        load RockyMtnPiedmont
        load SouthernRockies
        load RioGrandeRift
        MTs=[SouthernBnR;
            RioGrandeRift;
        RockyMtnPiedmont;
        SouthernRockies;];
    end
    
     if prov==16
        name='GulfCoast';
               GC=find(Mechs_all(:,2)<32.7 & Mechs_all(:,2)>26 & Mechs_all(:,1)>-103 & Mechs_all(:,1)<-90);

%         MTs=[SouthernBnR;
%             RioGrandeRift;
%         RockyMtnPiedmont;
%         SouthernRockies;];
MTs=Mechs_all(GC,1:3);
    end
   
    
    within=MTs(:,3);
    within=unique(within);
    
    
    
 
  
    
    StressData=Mechanisms_US(within,:);
    Locations=StressData(:,1:2);
    strike=StressData(:,3);
    dip=StressData(:,4);
    rake=StressData(:,5);
    num_obs=length(StressData);

    clear within 
    
    
    a=find(name~=' ');
    plot_file      = ['./SigmaPlots/Master_' name(a) ];

