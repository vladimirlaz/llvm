; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=thumbv8.1m.main -simplifycfg -S %s -o - | FileCheck %s --check-prefix=V8M
; RUN: opt -mtriple=thumbv8m.main -simplifycfg -S %s -o - | FileCheck %s --check-prefix=V8M
; RUN: opt -mtriple=thumbv8m.base -simplifycfg -S %s -o - | FileCheck %s --check-prefix=V8M
; RUN: opt -mtriple=armv8a -simplifycfg -S %s -o - | FileCheck %s --check-prefix=V8A

; Test that the phis from for.inc.preheader aren't hoisted into sw.bb92 because
; the cost is too great - we can make a better decision later on.
define i32 @multiple_spec_select_costs(i8* %a, i32* %idx, i8 %in) {
; V8M-LABEL: @multiple_spec_select_costs(
; V8M-NEXT:  entry:
; V8M-NEXT:    [[GEP_A_2:%.*]] = getelementptr inbounds i8, i8* [[A:%.*]], i32 2
; V8M-NEXT:    [[INCDEC_PTR109_C4:%.*]] = getelementptr inbounds i8, i8* [[A]], i32 3
; V8M-NEXT:    [[ZERO:%.*]] = icmp ne i8 [[IN:%.*]], 0
; V8M-NEXT:    br i1 [[ZERO]], label [[FOR_INC_PREHEADER:%.*]], label [[SW_BB92:%.*]]
; V8M:       sw.bb92:
; V8M-NEXT:    [[C_OFF_I150:%.*]] = add i8 [[IN]], -48
; V8M-NEXT:    [[UGT_9:%.*]] = icmp ugt i8 [[C_OFF_I150]], 9
; V8M-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[UGT_9]], i1 false, i1 true
; V8M-NEXT:    [[SPEC_SELECT1:%.*]] = select i1 [[UGT_9]], i32 1, i32 7
; V8M-NEXT:    br label [[FOR_INC_PREHEADER]]
; V8M:       for.inc.preheader:
; V8M-NEXT:    [[STR_PH_0:%.*]] = phi i8* [ [[GEP_A_2]], [[ENTRY:%.*]] ], [ [[INCDEC_PTR109_C4]], [[SW_BB92]] ]
; V8M-NEXT:    [[CMP:%.*]] = phi i1 [ false, [[ENTRY]] ], [ [[SPEC_SELECT]], [[SW_BB92]] ]
; V8M-NEXT:    [[PHI_RES:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[SPEC_SELECT1]], [[SW_BB92]] ]
; V8M-NEXT:    br label [[FOR_INC:%.*]]
; V8M:       for.inc:
; V8M-NEXT:    [[STR_PH_1:%.*]] = phi i8* [ [[INCDEC_PTR109:%.*]], [[FOR_BODY:%.*]] ], [ [[STR_PH_0]], [[FOR_INC_PREHEADER]] ]
; V8M-NEXT:    [[INCDEC_PTR109]] = getelementptr inbounds i8, i8* [[STR_PH_1]], i32 1
; V8M-NEXT:    [[LOAD_1:%.*]] = load i8, i8* [[INCDEC_PTR109]], align 1
; V8M-NEXT:    [[TOBOOL:%.*]] = icmp ne i8 [[LOAD_1]], 0
; V8M-NEXT:    [[AND:%.*]] = and i1 [[CMP]], [[TOBOOL]]
; V8M-NEXT:    br i1 [[AND]], label [[FOR_BODY]], label [[EXIT:%.*]]
; V8M:       for.body:
; V8M-NEXT:    [[CMP_1:%.*]] = icmp eq i8 [[LOAD_1]], 1
; V8M-NEXT:    br i1 [[CMP_1]], label [[FOR_INC]], label [[SW_BB92]]
; V8M:       exit:
; V8M-NEXT:    ret i32 [[PHI_RES]]
;
; V8A-LABEL: @multiple_spec_select_costs(
; V8A-NEXT:  entry:
; V8A-NEXT:    [[GEP_A_2:%.*]] = getelementptr inbounds i8, i8* [[A:%.*]], i32 2
; V8A-NEXT:    [[INCDEC_PTR109_C4:%.*]] = getelementptr inbounds i8, i8* [[A]], i32 3
; V8A-NEXT:    [[ZERO:%.*]] = icmp ne i8 [[IN:%.*]], 0
; V8A-NEXT:    br i1 [[ZERO]], label [[FOR_INC_PREHEADER:%.*]], label [[SW_BB92:%.*]]
; V8A:       sw.bb92:
; V8A-NEXT:    [[C_OFF_I150:%.*]] = add i8 [[IN]], -48
; V8A-NEXT:    [[UGT_9:%.*]] = icmp ugt i8 [[C_OFF_I150]], 9
; V8A-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[UGT_9]], i1 false, i1 true
; V8A-NEXT:    [[SPEC_SELECT1:%.*]] = select i1 [[UGT_9]], i32 1, i32 7
; V8A-NEXT:    br label [[FOR_INC_PREHEADER]]
; V8A:       for.inc.preheader:
; V8A-NEXT:    [[STR_PH_0:%.*]] = phi i8* [ [[GEP_A_2]], [[ENTRY:%.*]] ], [ [[INCDEC_PTR109_C4]], [[SW_BB92]] ]
; V8A-NEXT:    [[CMP:%.*]] = phi i1 [ false, [[ENTRY]] ], [ [[SPEC_SELECT]], [[SW_BB92]] ]
; V8A-NEXT:    [[PHI_RES:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[SPEC_SELECT1]], [[SW_BB92]] ]
; V8A-NEXT:    br label [[FOR_INC:%.*]]
; V8A:       for.inc:
; V8A-NEXT:    [[STR_PH_1:%.*]] = phi i8* [ [[INCDEC_PTR109:%.*]], [[FOR_BODY:%.*]] ], [ [[STR_PH_0]], [[FOR_INC_PREHEADER]] ]
; V8A-NEXT:    [[INCDEC_PTR109]] = getelementptr inbounds i8, i8* [[STR_PH_1]], i32 1
; V8A-NEXT:    [[LOAD_1:%.*]] = load i8, i8* [[INCDEC_PTR109]], align 1
; V8A-NEXT:    [[TOBOOL:%.*]] = icmp ne i8 [[LOAD_1]], 0
; V8A-NEXT:    [[AND:%.*]] = and i1 [[CMP]], [[TOBOOL]]
; V8A-NEXT:    br i1 [[AND]], label [[FOR_BODY]], label [[EXIT:%.*]]
; V8A:       for.body:
; V8A-NEXT:    [[CMP_1:%.*]] = icmp eq i8 [[LOAD_1]], 1
; V8A-NEXT:    br i1 [[CMP_1]], label [[FOR_INC]], label [[SW_BB92]]
; V8A:       exit:
; V8A-NEXT:    ret i32 [[PHI_RES]]
;
entry:
  %gep.a.2 = getelementptr inbounds i8, i8* %a, i32 2
  %incdec.ptr109.c4 = getelementptr inbounds i8, i8* %a, i32 3
  %zero = icmp ne i8 %in, 0
  br i1 %zero , label %for.inc.preheader, label %sw.bb92

sw.bb92:
  %c.off.i150 = add i8 %in, -48
  %ugt.9 = icmp ugt i8 %c.off.i150, 9
  br i1 %ugt.9, label %for.inc.preheader, label %select.unfold198

select.unfold198:
  br label %for.inc.preheader

for.inc.preheader:
  %str.ph.0 = phi i8* [ %incdec.ptr109.c4, %select.unfold198 ], [ %incdec.ptr109.c4, %sw.bb92 ], [ %gep.a.2, %entry ]
  %cmp = phi i1 [ true, %select.unfold198 ], [ false, %sw.bb92 ], [ false, %entry ]
  %phi.res = phi i32 [ 7, %select.unfold198 ], [ 1, %sw.bb92 ], [ 1, %entry ]
  br label %for.inc

for.inc:
  %str.ph.1 = phi i8* [ %incdec.ptr109, %for.body ], [ %str.ph.0, %for.inc.preheader ]
  %incdec.ptr109 = getelementptr inbounds i8, i8* %str.ph.1, i32 1
  %load.1 = load i8, i8* %incdec.ptr109, align 1
  %tobool = icmp ne i8 %load.1, 0
  %and = and i1 %cmp, %tobool
  br i1 %and, label %for.body, label %exit

for.body:
  %cmp.1 = icmp eq i8 %load.1, 1
  br i1 %cmp.1, label %for.inc, label %sw.bb92

exit:
  ret i32 %phi.res
}

define i32 @multiple_spec_select_costs_minsize(i8* %a, i32* %idx, i8 %in) #0 {
; V8M-LABEL: @multiple_spec_select_costs_minsize(
; V8M-NEXT:  entry:
; V8M-NEXT:    [[GEP_A_2:%.*]] = getelementptr inbounds i8, i8* [[A:%.*]], i32 2
; V8M-NEXT:    [[INCDEC_PTR109_C4:%.*]] = getelementptr inbounds i8, i8* [[A]], i32 3
; V8M-NEXT:    [[ZERO:%.*]] = icmp ne i8 [[IN:%.*]], 0
; V8M-NEXT:    br i1 [[ZERO]], label [[FOR_INC_PREHEADER:%.*]], label [[SW_BB92:%.*]]
; V8M:       sw.bb92:
; V8M-NEXT:    [[C_OFF_I150:%.*]] = add i8 [[IN]], -48
; V8M-NEXT:    [[UGT_9:%.*]] = icmp ugt i8 [[C_OFF_I150]], 9
; V8M-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[UGT_9]], i1 false, i1 true
; V8M-NEXT:    [[SPEC_SELECT1:%.*]] = select i1 [[UGT_9]], i32 1, i32 7
; V8M-NEXT:    br label [[FOR_INC_PREHEADER]]
; V8M:       for.inc.preheader:
; V8M-NEXT:    [[STR_PH_0:%.*]] = phi i8* [ [[GEP_A_2]], [[ENTRY:%.*]] ], [ [[INCDEC_PTR109_C4]], [[SW_BB92]] ]
; V8M-NEXT:    [[CMP:%.*]] = phi i1 [ false, [[ENTRY]] ], [ [[SPEC_SELECT]], [[SW_BB92]] ]
; V8M-NEXT:    [[PHI_RES:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[SPEC_SELECT1]], [[SW_BB92]] ]
; V8M-NEXT:    br label [[FOR_INC:%.*]]
; V8M:       for.inc:
; V8M-NEXT:    [[STR_PH_1:%.*]] = phi i8* [ [[INCDEC_PTR109:%.*]], [[FOR_BODY:%.*]] ], [ [[STR_PH_0]], [[FOR_INC_PREHEADER]] ]
; V8M-NEXT:    [[INCDEC_PTR109]] = getelementptr inbounds i8, i8* [[STR_PH_1]], i32 1
; V8M-NEXT:    [[LOAD_1:%.*]] = load i8, i8* [[INCDEC_PTR109]], align 1
; V8M-NEXT:    [[TOBOOL:%.*]] = icmp ne i8 [[LOAD_1]], 0
; V8M-NEXT:    [[AND:%.*]] = and i1 [[CMP]], [[TOBOOL]]
; V8M-NEXT:    br i1 [[AND]], label [[FOR_BODY]], label [[EXIT:%.*]]
; V8M:       for.body:
; V8M-NEXT:    [[CMP_1:%.*]] = icmp eq i8 [[LOAD_1]], 1
; V8M-NEXT:    br i1 [[CMP_1]], label [[FOR_INC]], label [[SW_BB92]]
; V8M:       exit:
; V8M-NEXT:    ret i32 [[PHI_RES]]
;
; V8A-LABEL: @multiple_spec_select_costs_minsize(
; V8A-NEXT:  entry:
; V8A-NEXT:    [[GEP_A_2:%.*]] = getelementptr inbounds i8, i8* [[A:%.*]], i32 2
; V8A-NEXT:    [[INCDEC_PTR109_C4:%.*]] = getelementptr inbounds i8, i8* [[A]], i32 3
; V8A-NEXT:    [[ZERO:%.*]] = icmp ne i8 [[IN:%.*]], 0
; V8A-NEXT:    br i1 [[ZERO]], label [[FOR_INC_PREHEADER:%.*]], label [[SW_BB92:%.*]]
; V8A:       sw.bb92:
; V8A-NEXT:    [[C_OFF_I150:%.*]] = add i8 [[IN]], -48
; V8A-NEXT:    [[UGT_9:%.*]] = icmp ugt i8 [[C_OFF_I150]], 9
; V8A-NEXT:    [[SPEC_SELECT:%.*]] = select i1 [[UGT_9]], i1 false, i1 true
; V8A-NEXT:    [[SPEC_SELECT1:%.*]] = select i1 [[UGT_9]], i32 1, i32 7
; V8A-NEXT:    br label [[FOR_INC_PREHEADER]]
; V8A:       for.inc.preheader:
; V8A-NEXT:    [[STR_PH_0:%.*]] = phi i8* [ [[GEP_A_2]], [[ENTRY:%.*]] ], [ [[INCDEC_PTR109_C4]], [[SW_BB92]] ]
; V8A-NEXT:    [[CMP:%.*]] = phi i1 [ false, [[ENTRY]] ], [ [[SPEC_SELECT]], [[SW_BB92]] ]
; V8A-NEXT:    [[PHI_RES:%.*]] = phi i32 [ 1, [[ENTRY]] ], [ [[SPEC_SELECT1]], [[SW_BB92]] ]
; V8A-NEXT:    br label [[FOR_INC:%.*]]
; V8A:       for.inc:
; V8A-NEXT:    [[STR_PH_1:%.*]] = phi i8* [ [[INCDEC_PTR109:%.*]], [[FOR_BODY:%.*]] ], [ [[STR_PH_0]], [[FOR_INC_PREHEADER]] ]
; V8A-NEXT:    [[INCDEC_PTR109]] = getelementptr inbounds i8, i8* [[STR_PH_1]], i32 1
; V8A-NEXT:    [[LOAD_1:%.*]] = load i8, i8* [[INCDEC_PTR109]], align 1
; V8A-NEXT:    [[TOBOOL:%.*]] = icmp ne i8 [[LOAD_1]], 0
; V8A-NEXT:    [[AND:%.*]] = and i1 [[CMP]], [[TOBOOL]]
; V8A-NEXT:    br i1 [[AND]], label [[FOR_BODY]], label [[EXIT:%.*]]
; V8A:       for.body:
; V8A-NEXT:    [[CMP_1:%.*]] = icmp eq i8 [[LOAD_1]], 1
; V8A-NEXT:    br i1 [[CMP_1]], label [[FOR_INC]], label [[SW_BB92]]
; V8A:       exit:
; V8A-NEXT:    ret i32 [[PHI_RES]]
;
entry:
  %gep.a.2 = getelementptr inbounds i8, i8* %a, i32 2
  %incdec.ptr109.c4 = getelementptr inbounds i8, i8* %a, i32 3
  %zero = icmp ne i8 %in, 0
  br i1 %zero , label %for.inc.preheader, label %sw.bb92

sw.bb92:
  %c.off.i150 = add i8 %in, -48
  %ugt.9 = icmp ugt i8 %c.off.i150, 9
  br i1 %ugt.9, label %for.inc.preheader, label %select.unfold198

select.unfold198:
  br label %for.inc.preheader

for.inc.preheader:
  %str.ph.0 = phi i8* [ %incdec.ptr109.c4, %select.unfold198 ], [ %incdec.ptr109.c4, %sw.bb92 ], [ %gep.a.2, %entry ]
  %cmp = phi i1 [ true, %select.unfold198 ], [ false, %sw.bb92 ], [ false, %entry ]
  %phi.res = phi i32 [ 7, %select.unfold198 ], [ 1, %sw.bb92 ], [ 1, %entry ]
  br label %for.inc

for.inc:
  %str.ph.1 = phi i8* [ %incdec.ptr109, %for.body ], [ %str.ph.0, %for.inc.preheader ]
  %incdec.ptr109 = getelementptr inbounds i8, i8* %str.ph.1, i32 1
  %load.1 = load i8, i8* %incdec.ptr109, align 1
  %tobool = icmp ne i8 %load.1, 0
  %and = and i1 %cmp, %tobool
  br i1 %and, label %for.body, label %exit

for.body:
  %cmp.1 = icmp eq i8 %load.1, 1
  br i1 %cmp.1, label %for.inc, label %sw.bb92

exit:
  ret i32 %phi.res
}

attributes #0 = { minsize optsize }
