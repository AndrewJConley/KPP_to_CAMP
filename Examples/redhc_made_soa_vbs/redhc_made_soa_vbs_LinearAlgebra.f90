! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Linear Algebra Data and Routines File
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
! File                 : redhc_made_soa_vbs_LinearAlgebra.f90
! Time                 : Wed Oct 28 17:42:24 2020
! Working directory    : /mnt/lfs1/BMC/fim/Jordan/models/rapid-refresh/WRFV3.9_RAPCHEM_v7/chem/KPP/mechanisms/redhc_made_soa_vbs
! Equation file        : redhc_made_soa_vbs.kpp
! Output root filename : redhc_made_soa_vbs
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE redhc_made_soa_vbs_LinearAlgebra

  USE redhc_made_soa_vbs_Parameters
  USE redhc_made_soa_vbs_JacobianSP

  IMPLICIT NONE

CONTAINS


! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! KppSolveTR - sparse, transposed back substitution
!   Arguments :
!      JVS       - sparse Jacobian of variables
!      X         - Vector for variables
!      XX        - Vector for output variables
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUBROUTINE KppSolveTR ( JVS, X, XX )

! JVS - sparse Jacobian of variables
  REAL(kind=dp) :: JVS(LU_NONZERO)
! X - Vector for variables
  REAL(kind=dp) :: X(NVAR)
! XX - Vector for output variables
  REAL(kind=dp) :: XX(NVAR)

  XX(1) = X(1)/JVS(1)
  XX(2) = X(2)/JVS(3)
  XX(3) = X(3)/JVS(5)
  XX(4) = (X(4)-JVS(6)*XX(3))/(JVS(8))
  XX(5) = (X(5)-JVS(9)*XX(4))/(JVS(11))
  XX(6) = (X(6)-JVS(12)*XX(5))/(JVS(14))
  XX(7) = X(7)/JVS(16)
  XX(8) = (X(8)-JVS(17)*XX(7))/(JVS(20))
  XX(9) = (X(9)-JVS(21)*XX(8))/(JVS(24))
  XX(10) = (X(10)-JVS(25)*XX(9))/(JVS(28))
  XX(11) = (X(11)-JVS(29)*XX(10))/(JVS(32))
  XX(12) = (X(12)-JVS(30)*XX(10))/(JVS(34))
  XX(13) = (X(13)-JVS(26)*XX(9))/(JVS(36))
  XX(14) = (X(14)-JVS(22)*XX(8))/(JVS(38))
  XX(15) = (X(15)-JVS(18)*XX(7))/(JVS(40))
  XX(16) = X(16)/JVS(42)
  XX(17) = (X(17)-JVS(43)*XX(16))/(JVS(45))
  XX(18) = X(18)/JVS(47)
  XX(19) = X(19)/JVS(49)
  XX(20) = X(20)/JVS(52)
  XX(21) = X(21)/JVS(55)
  XX(22) = X(22)/JVS(58)
  XX(23) = X(23)/JVS(65)
  XX(24) = (X(24)-JVS(59)*XX(22))/(JVS(67))
  XX(25) = X(25)/JVS(70)
  XX(26) = X(26)/JVS(76)
  XX(27) = X(27)/JVS(80)
  XX(28) = X(28)/JVS(83)
  XX(29) = X(29)/JVS(91)
  XX(30) = (X(30)-JVS(92)*XX(29))/(JVS(103))
  XX(31) = X(31)/JVS(109)
  XX(32) = (X(32)-JVS(93)*XX(29)-JVS(110)*XX(31))/(JVS(117))
  XX(33) = (X(33)-JVS(104)*XX(30))/(JVS(121))
  XX(34) = (X(34)-JVS(60)*XX(22)-JVS(68)*XX(24))/(JVS(129))
  XX(35) = (X(35)-JVS(94)*XX(29)-JVS(111)*XX(31)-JVS(130)*XX(34))/(JVS(136))
  XX(36) = (X(36)-JVS(95)*XX(29)-JVS(105)*XX(30)-JVS(112)*XX(31)-JVS(131)*XX(34))/(JVS(140))
  XX(37) = (X(37)-JVS(61)*XX(22)-JVS(96)*XX(29)-JVS(132)*XX(34))/(JVS(146))
  XX(38) = (X(38)-JVS(84)*XX(28)-JVS(97)*XX(29))/(JVS(158))
  XX(39) = (X(39)-JVS(85)*XX(28)-JVS(98)*XX(29))/(JVS(169))
  XX(40) = (X(40)-JVS(71)*XX(25)-JVS(113)*XX(31))/(JVS(183))
  XX(41) = (X(41)-JVS(72)*XX(25))/(JVS(203))
  XX(42) = (X(42)-JVS(62)*XX(22)-JVS(81)*XX(27)-JVS(99)*XX(29)-JVS(106)*XX(30)-JVS(118)*XX(32)-JVS(122)*XX(33)-JVS(133)&
             &*XX(34)-JVS(137)*XX(35)-JVS(141)*XX(36)-JVS(147)*XX(37)-JVS(159)*XX(38)-JVS(170)*XX(39)-JVS(184)*XX(40)&
             &-JVS(204)*XX(41))/(JVS(216))
  XX(43) = (X(43)-JVS(2)*XX(1)-JVS(4)*XX(2)-JVS(7)*XX(3)-JVS(10)*XX(4)-JVS(13)*XX(5)-JVS(15)*XX(6)-JVS(19)*XX(7)-JVS(23)&
             &*XX(8)-JVS(27)*XX(9)-JVS(31)*XX(10)-JVS(33)*XX(11)-JVS(35)*XX(12)-JVS(37)*XX(13)-JVS(39)*XX(14)-JVS(41)*XX(15)&
             &-JVS(44)*XX(16)-JVS(46)*XX(17)-JVS(48)*XX(18)-JVS(50)*XX(19)-JVS(63)*XX(22)-JVS(66)*XX(23)-JVS(69)*XX(24)&
             &-JVS(73)*XX(25)-JVS(77)*XX(26)-JVS(82)*XX(27)-JVS(86)*XX(28)-JVS(100)*XX(29)-JVS(107)*XX(30)-JVS(114)*XX(31)&
             &-JVS(119)*XX(32)-JVS(123)*XX(33)-JVS(134)*XX(34)-JVS(138)*XX(35)-JVS(142)*XX(36)-JVS(148)*XX(37)-JVS(160)&
             &*XX(38)-JVS(171)*XX(39)-JVS(185)*XX(40)-JVS(205)*XX(41)-JVS(217)*XX(42))/(JVS(244))
  XX(44) = (X(44)-JVS(51)*XX(19)-JVS(74)*XX(25)-JVS(78)*XX(26)-JVS(172)*XX(39)-JVS(186)*XX(40)-JVS(206)*XX(41)-JVS(218)&
             &*XX(42)-JVS(245)*XX(43))/(JVS(270))
  XX(45) = (X(45)-JVS(115)*XX(31)-JVS(173)*XX(39)-JVS(187)*XX(40)-JVS(207)*XX(41)-JVS(219)*XX(42)-JVS(246)*XX(43)&
             &-JVS(271)*XX(44))/(JVS(280))
  XX(46) = (X(46)-JVS(53)*XX(20)-JVS(56)*XX(21)-JVS(79)*XX(26)-JVS(87)*XX(28)-JVS(220)*XX(42)-JVS(247)*XX(43)-JVS(272)&
             &*XX(44)-JVS(281)*XX(45))/(JVS(301))
  XX(47) = (X(47)-JVS(54)*XX(20)-JVS(75)*XX(25)-JVS(174)*XX(39)-JVS(208)*XX(41)-JVS(248)*XX(43)-JVS(273)*XX(44)-JVS(282)&
             &*XX(45)-JVS(302)*XX(46))/(JVS(316))
  XX(48) = (X(48)-JVS(57)*XX(21)-JVS(64)*XX(22)-JVS(88)*XX(28)-JVS(101)*XX(29)-JVS(108)*XX(30)-JVS(116)*XX(31)-JVS(120)&
             &*XX(32)-JVS(124)*XX(33)-JVS(135)*XX(34)-JVS(139)*XX(35)-JVS(143)*XX(36)-JVS(149)*XX(37)-JVS(161)*XX(38)&
             &-JVS(175)*XX(39)-JVS(188)*XX(40)-JVS(209)*XX(41)-JVS(221)*XX(42)-JVS(249)*XX(43)-JVS(274)*XX(44)-JVS(283)&
             &*XX(45)-JVS(303)*XX(46)-JVS(317)*XX(47))/(JVS(334))
  XX(48) = XX(48)
  XX(47) = XX(47)-JVS(333)*XX(48)
  XX(46) = XX(46)-JVS(315)*XX(47)-JVS(332)*XX(48)
  XX(45) = XX(45)-JVS(300)*XX(46)-JVS(314)*XX(47)-JVS(331)*XX(48)
  XX(44) = XX(44)-JVS(279)*XX(45)-JVS(299)*XX(46)-JVS(313)*XX(47)-JVS(330)*XX(48)
  XX(43) = XX(43)-JVS(269)*XX(44)-JVS(278)*XX(45)-JVS(298)*XX(46)-JVS(312)*XX(47)-JVS(329)*XX(48)
  XX(42) = XX(42)-JVS(243)*XX(43)-JVS(268)*XX(44)-JVS(277)*XX(45)-JVS(297)*XX(46)-JVS(311)*XX(47)-JVS(328)*XX(48)
  XX(41) = XX(41)-JVS(242)*XX(43)-JVS(267)*XX(44)-JVS(276)*XX(45)-JVS(296)*XX(46)
  XX(40) = XX(40)-JVS(202)*XX(41)-JVS(241)*XX(43)-JVS(266)*XX(44)-JVS(275)*XX(45)-JVS(295)*XX(46)
  XX(39) = XX(39)-JVS(240)*XX(43)-JVS(265)*XX(44)-JVS(294)*XX(46)-JVS(327)*XX(48)
  XX(38) = XX(38)-JVS(168)*XX(39)-JVS(201)*XX(41)-JVS(239)*XX(43)-JVS(264)*XX(44)-JVS(293)*XX(46)-JVS(310)*XX(47)&
             &-JVS(326)*XX(48)
  XX(37) = XX(37)-JVS(157)*XX(38)-JVS(167)*XX(39)-JVS(182)*XX(40)-JVS(200)*XX(41)-JVS(215)*XX(42)-JVS(238)*XX(43)&
             &-JVS(263)*XX(44)-JVS(292)*XX(46)-JVS(325)*XX(48)
  XX(36) = XX(36)-JVS(145)*XX(37)-JVS(156)*XX(38)-JVS(166)*XX(39)-JVS(181)*XX(40)-JVS(199)*XX(41)-JVS(214)*XX(42)&
             &-JVS(237)*XX(43)-JVS(262)*XX(44)-JVS(291)*XX(46)-JVS(309)*XX(47)-JVS(324)*XX(48)
  XX(35) = XX(35)-JVS(155)*XX(38)-JVS(165)*XX(39)-JVS(180)*XX(40)-JVS(198)*XX(41)-JVS(213)*XX(42)-JVS(236)*XX(43)&
             &-JVS(261)*XX(44)-JVS(290)*XX(46)-JVS(308)*XX(47)-JVS(323)*XX(48)
  XX(34) = XX(34)-JVS(154)*XX(38)-JVS(179)*XX(40)-JVS(197)*XX(41)-JVS(235)*XX(43)-JVS(260)*XX(44)
  XX(33) = XX(33)-JVS(128)*XX(34)-JVS(144)*XX(37)-JVS(153)*XX(38)-JVS(164)*XX(39)-JVS(178)*XX(40)-JVS(196)*XX(41)&
             &-JVS(212)*XX(42)-JVS(234)*XX(43)-JVS(259)*XX(44)-JVS(307)*XX(47)-JVS(322)*XX(48)
  XX(32) = XX(32)-JVS(127)*XX(34)-JVS(152)*XX(38)-JVS(163)*XX(39)-JVS(177)*XX(40)-JVS(195)*XX(41)-JVS(211)*XX(42)&
             &-JVS(233)*XX(43)-JVS(258)*XX(44)-JVS(289)*XX(46)-JVS(321)*XX(48)
  XX(31) = XX(31)-JVS(194)*XX(41)-JVS(232)*XX(43)-JVS(257)*XX(44)-JVS(288)*XX(46)
  XX(30) = XX(30)-JVS(193)*XX(41)-JVS(231)*XX(43)-JVS(256)*XX(44)-JVS(306)*XX(47)
  XX(29) = XX(29)-JVS(230)*XX(43)-JVS(255)*XX(44)
  XX(28) = XX(28)-JVS(229)*XX(43)-JVS(287)*XX(46)-JVS(320)*XX(48)
  XX(27) = XX(27)-JVS(90)*XX(29)-JVS(151)*XX(38)-JVS(162)*XX(39)-JVS(192)*XX(41)-JVS(210)*XX(42)-JVS(228)*XX(43)&
             &-JVS(254)*XX(44)
  XX(26) = XX(26)-JVS(227)*XX(43)-JVS(253)*XX(44)-JVS(286)*XX(46)-JVS(319)*XX(48)
  XX(25) = XX(25)-JVS(191)*XX(41)-JVS(226)*XX(43)
  XX(24) = XX(24)-JVS(126)*XX(34)-JVS(150)*XX(38)-JVS(190)*XX(41)-JVS(252)*XX(44)
  XX(23) = XX(23)-JVS(89)*XX(29)-JVS(102)*XX(30)-JVS(176)*XX(40)-JVS(189)*XX(41)-JVS(225)*XX(43)-JVS(251)*XX(44)&
             &-JVS(305)*XX(47)
  XX(22) = XX(22)-JVS(125)*XX(34)
  XX(21) = XX(21)-JVS(285)*XX(46)-JVS(318)*XX(48)
  XX(20) = XX(20)-JVS(284)*XX(46)-JVS(304)*XX(47)
  XX(19) = XX(19)-JVS(224)*XX(43)-JVS(250)*XX(44)
  XX(18) = XX(18)-JVS(223)*XX(43)
  XX(17) = XX(17)-JVS(222)*XX(43)
  XX(16) = XX(16)
  XX(15) = XX(15)
  XX(14) = XX(14)
  XX(13) = XX(13)
  XX(12) = XX(12)
  XX(11) = XX(11)
  XX(10) = XX(10)
  XX(9) = XX(9)
  XX(8) = XX(8)
  XX(7) = XX(7)
  XX(6) = XX(6)
  XX(5) = XX(5)
  XX(4) = XX(4)
  XX(3) = XX(3)
  XX(2) = XX(2)
  XX(1) = XX(1)
      
END SUBROUTINE KppSolveTR

! End of KppSolveTR function
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



END MODULE redhc_made_soa_vbs_LinearAlgebra

