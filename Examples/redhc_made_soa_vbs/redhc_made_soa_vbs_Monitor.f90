! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Utility Data Module File
! 
! Generated by KPP-2.1 symbolic chemistry Kinetics PreProcessor
!       (http://www.cs.vt.edu/~asandu/Software/KPP)
! KPP is distributed under GPL, the general public licence
!       (http://www.gnu.org/copyleft/gpl.html)
! (C) 1995-1997, V. Damian & A. Sandu, CGRER, Univ. Iowa
! (C) 1997-2005, A. Sandu, Michigan Tech, Virginia Tech
!     With important contributions from:
!        M. Damian, Villanova University, USA
!        R. Sander, Max-Planck Institute for Chemistry, Mainz, Germany
! 
! File                 : redhc_made_soa_vbs_Monitor.f90
! Time                 : Wed Oct 28 17:42:24 2020
! Working directory    : /mnt/lfs1/BMC/fim/Jordan/models/rapid-refresh/WRFV3.9_RAPCHEM_v7/chem/KPP/mechanisms/redhc_made_soa_vbs
! Equation file        : redhc_made_soa_vbs.kpp
! Output root filename : redhc_made_soa_vbs
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE redhc_made_soa_vbs_Monitor


  CHARACTER(LEN=12), PARAMETER, DIMENSION(50) :: SPC_NAMES = (/ &
     'IVOC        ','SOAALK      ','CVBSOA1     ', &
     'CVBSOA2     ','CVBSOA3     ','CVBSOA4     ', &
     'CVASOA0     ','CVASOA1     ','CVASOA2     ', &
     'CVASOA3     ','CVASOA4     ','CVPOA4      ', &
     'CVPOA3      ','CVPOA2      ','CVPOA1      ', &
     'SULF        ','SO2         ','NH3         ', &
     'H2O2        ','PAN         ','N2O5        ', &
     'RXPAR_nt    ','TOLUENE     ','ROR         ', &
     'ROOH        ','HO2NO2      ','C2H4        ', &
     'HNO3        ','CO          ','CH3COCHO    ', &
     'ONIT        ','MBO         ','SESQ        ', &
     'PAR         ','C10H16      ','ISOP        ', &
     'OLE         ','CH3CHO      ','CH2O        ', &
     'XO2N_nt     ','XO2_nt      ','O3          ', &
     'OH_nt       ','HO2_nt      ','NO          ', &
     'NO2         ','C2O3_nt     ','NO3_nt      ', &
     'H2O         ','M           ' /)

  INTEGER, DIMENSION(1) :: LOOKAT
  INTEGER, DIMENSION(1) :: MONITOR
  CHARACTER(LEN=12), DIMENSION(1) :: SMASS
  CHARACTER(LEN=100), PARAMETER, DIMENSION(30) :: EQN_NAMES_0 = (/ &
     '              O3 --> 2 OH_nt                                                                        ', &
     '             NO2 --> O3 + NO                                                                        ', &
     '            N2O5 --> NO2 + NO3_nt                                                                   ', &
     '            HNO3 --> OH_nt + NO2                                                                    ', &
     '          NO3_nt --> 0.89 O3 + 0.11 NO + 0.89 NO2                                                   ', &
     '          HO2NO2 --> 0.33 OH_nt + 0.66 HO2_nt + 0.66 NO2 + 0.33 NO3_nt                              ', &
     '            CH2O --> CO + 2 HO2_nt                                                                  ', &
     '            CH2O --> CO                                                                             ', &
     '            H2O2 --> 2 OH_nt                                                                        ', &
     '          CH3CHO --> CO + CH2O + XO2_nt + 2 HO2_nt                                                  ', &
     '        CH3COCHO --> CO + HO2_nt + C2O3_nt                                                          ', &
     '             PAN --> NO2 + C2O3_nt                                                                  ', &
     '            ROOH --> OH_nt                                                                          ', &
     '            ONIT --> HO2_nt + NO2                                                                   ', &
     '      O3 + OH_nt --> HO2_nt                                                                         ', &
     '     O3 + HO2_nt --> OH_nt                                                                          ', &
     '  2 HO2_nt + H2O --> H2O2                                                                           ', &
     '    H2O2 + OH_nt --> HO2_nt + H2O                                                                   ', &
     '  OH_nt + HO2_nt --> H2O                                                                            ', &
     '         2 OH_nt --> O3 + H2O                                                                       ', &
     '         2 OH_nt --> H2O2                                                                           ', &
     '     HO2_nt + NO --> OH_nt + NO2                                                                    ', &
     '         O3 + NO --> NO2                                                                            ', &
     '        O3 + NO2 --> NO3_nt                                                                         ', &
     ' HO2_nt + NO3_nt --> OH_nt + NO2                                                                    ', &
     '    NO2 + NO3_nt --> N2O5                                                                           ', &
     '            N2O5 --> NO2 + NO3_nt                                                                   ', &
     '     OH_nt + NO2 --> HNO3                                                                           ', &
     '    HNO3 + OH_nt --> NO3_nt + H2O                                                                   ', &
     '     NO + NO3_nt --> 2 NO2                                                                          ' /)
  CHARACTER(LEN=100), PARAMETER, DIMENSION(30) :: EQN_NAMES_1 = (/ &
     '    HO2_nt + NO2 --> HO2NO2                                                                         ', &
     '  HO2NO2 + OH_nt --> NO2 + H2O                                                                      ', &
     '          HO2NO2 --> HO2_nt + NO2                                                                   ', &
     '   CH2O + NO3_nt --> HNO3 + CO + HO2_nt                                                             ', &
     '    CH2O + OH_nt --> CO + HO2_nt + H2O                                                              ', &
     '      CO + OH_nt --> HO2_nt                                                                         ', &
     '           OH_nt --> CH2O + XO2_nt + HO2_nt                                                         ', &
     '  CH3CHO + OH_nt --> C2O3_nt                                                                        ', &
     ' CH3CHO + NO3_nt --> HNO3 + C2O3_nt                                                                 ', &
     '    NO + C2O3_nt --> CH2O + XO2_nt + HO2_nt + NO2                                                   ', &
     '   NO2 + C2O3_nt --> PAN                                                                            ', &
     '             PAN --> NO2 + C2O3_nt                                                                  ', &
     '       2 C2O3_nt --> 2 CH2O + 2 XO2_nt + 2 HO2_nt                                                   ', &
     'HO2_nt + C2O3_nt --> 0.21 ROOH + CH2O + XO2_nt + 0.79 OH_nt + HO2_nt                                ', &
     '     PAR + OH_nt --> 0.11 RXPAR_nt + 0.76 ROR + 0.11 CH3CHO + 0.13 XO2N_nt + 0.87 XO2_nt + 0.11 HO2_', &
     '             ROR --> 2.1 RXPAR_nt + 1.1 CH3CHO + 0.96 XO2_nt + 0.94 HO2_nt                          ', &
     '             ROR --> HO2_nt                                                                         ', &
     '     OLE + OH_nt --> RXPAR_nt + CH3CHO + CH2O + XO2_nt + HO2_nt                                     ', &
     '        OLE + O3 --> 0.9 RXPAR_nt + 0.37 CO + 0.44 CH3CHO + 0.64 CH2O + 0.29 XO2_nt + 0.4 OH_nt + 0.', &
     '    OLE + NO3_nt --> RXPAR_nt + CH3CHO + CH2O + 0.09 XO2N_nt + 0.91 XO2_nt + NO2                    ', &
     '       C2H4 + O3 --> 0.43 CO + CH2O + 0.12 OH_nt + 0.26 HO2_nt                                      ', &
     '    C2H4 + OH_nt --> 0.22 CH3CHO + 1.56 CH2O + XO2_nt + HO2_nt                                      ', &
     'CH3COCHO + OH_nt --> XO2_nt + C2O3_nt                                                               ', &
     '    ISOP + OH_nt --> 0.03 CH3COCHO + 0.63 PAR + 0.58 OLE + 0.61 CH2O + 0.15 XO2N_nt + 0.85 XO2_nt + ', &
     '       ISOP + O3 --> 0.36 CO + 0.03 CH3COCHO + 0.63 PAR + 0.55 OLE + 0.9 CH2O + 0.18 XO2_nt + 0.28 O', &
     '   ISOP + NO3_nt --> 0.08 CH3COCHO + 0.9 ONIT + 0.45 OLE + 0.12 CH3CHO + 0.03 CH2O + 0.9 HO2_nt + 0.', &
     '    ROOH + OH_nt --> 0.7 XO2_nt + 0.3 OH_nt                                                         ', &
     '    ONIT + OH_nt --> XO2_nt + NO2                                                                   ', &
     '     XO2_nt + NO --> NO2                                                                            ', &
     '        2 XO2_nt --> M                                                                              ' /)
  CHARACTER(LEN=100), PARAMETER, DIMENSION(29) :: EQN_NAMES_2 = (/ &
     '    XO2N_nt + NO --> ONIT                                                                           ', &
     ' XO2_nt + HO2_nt --> ROOH                                                                           ', &
     'XO2N_nt + HO2_nt --> ROOH                                                                           ', &
     '  RXPAR_nt + PAR --> M                                                                              ', &
     '     SO2 + OH_nt --> SULF                                                                           ', &
     '     NH3 + OH_nt --> M                                                                              ', &
     ' TOLUENE + OH_nt --> 0.4 CO + 0.85 CH3COCHO + 0.2 XO2N_nt + 0.6 XO2_nt + 0.6 HO2_nt + 0.1 C2O3_nt   ', &
     '     C10H16 + O3 --> 0.001 CO + 7 PAR + 0.21 CH3CHO + 0.24 CH2O + 0.18 XO2N_nt + 0.76 XO2_nt + 0.57 ', &
     '  C10H16 + OH_nt --> 1.66 PAR + 0.47 CH3CHO + 0.28 CH2O + 0.25 XO2N_nt + 1.25 XO2_nt + 0.75 HO2_nt  ', &
     ' C10H16 + NO3_nt --> 0.53 ONIT + 0.47 CH3CHO + 0.25 XO2N_nt + 1.03 XO2_nt + 0.28 HO2_nt + 0.47 NO2  ', &
     '       SESQ + O3 --> 0.21 PAR + 0.85 CH3CHO + 0.51 CH2O + 0.63 OH_nt                                ', &
     '    SESQ + OH_nt --> 0.324 PAR + 0.3 CH2O + 0.19 XO2_nt                                             ', &
     '   SESQ + NO3_nt --> 0.027 CH3COCHO + 0.522 OLE + XO2N_nt                                           ', &
     '        MBO + O3 --> 0.635 CO + 0.085 PAR + 0.369 OH_nt + 0.084 HO2_nt                              ', &
     '     MBO + OH_nt --> 0.185 PAR + 0.935 CH3CHO + 0.311 CH2O + 0.065 XO2N_nt + 0.935 XO2_nt           ', &
     '  CVPOA4 + OH_nt --> 1.667 CVASOA3 + OH_nt                                                          ', &
     '  CVPOA3 + OH_nt --> 1.667 CVASOA2 + OH_nt                                                          ', &
     '  CVPOA2 + OH_nt --> 1.667 CVASOA1 + OH_nt                                                          ', &
     '  CVPOA1 + OH_nt --> 1.667 CVASOA0 + OH_nt                                                          ', &
     ' CVASOA4 + OH_nt --> CVASOA3 + OH_nt                                                                ', &
     ' CVASOA3 + OH_nt --> CVASOA2 + OH_nt                                                                ', &
     ' CVASOA2 + OH_nt --> CVASOA1 + OH_nt                                                                ', &
     ' CVASOA1 + OH_nt --> CVASOA0 + OH_nt                                                                ', &
     ' CVBSOA4 + OH_nt --> CVBSOA3 + OH_nt                                                                ', &
     ' CVBSOA3 + OH_nt --> CVBSOA2 + OH_nt                                                                ', &
     ' CVBSOA2 + OH_nt --> CVBSOA1 + OH_nt                                                                ', &
     '    IVOC + OH_nt --> OH_nt                                                                          ', &
     '  SOAALK + OH_nt --> OH_nt                                                                          ', &
     '    MBO + NO3_nt --> ONIT                                                                           ' /)
  CHARACTER(LEN=100), PARAMETER, DIMENSION(89) :: EQN_NAMES = (/&
    EQN_NAMES_0, EQN_NAMES_1, EQN_NAMES_2 /)

! INLINED global variables

! End INLINED global variables


END MODULE redhc_made_soa_vbs_Monitor