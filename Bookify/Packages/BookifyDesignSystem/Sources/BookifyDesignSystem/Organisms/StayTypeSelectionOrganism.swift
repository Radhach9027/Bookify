//
//  StayTypeSelectionOrganism.swift
//  BookifyDesignSystem
//
//  Created by radha chilamkurthy on 11/11/25.
//

import SwiftUI

public enum StayType: String, CaseIterable, Identifiable {
    case hourly = "Hourly", night = "Night";
    public var id: String { rawValue }
}

public struct StayTypeSelectionProps: Equatable {
    public var type: StayType
    public var selectedHours: Int
    public var hourOptions: [Int]
    public var startTime: Date
    public var checkIn: Date
    public var checkOut: Date
    
    public init(
        type: StayType = .hourly,
        selectedHours: Int = 3,
        hourOptions: [Int] = [3,6,9],
        startTime: Date = .init(),
        checkIn: Date = Calendar.current.startOfDay(for: .init()),
        checkOut: Date = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: .init()))!
    ) {
        self.type = type;
        self.selectedHours = selectedHours;
        self.hourOptions = hourOptions;
        self.startTime = startTime;
        self.checkIn = checkIn;
        self.checkOut = checkOut
    }
}

public enum StayTypeSelectionAction {
    case setType(StayType)
    case setHours(Int)
    case setStartTime(Date)
    case setCheckIn(Date)
    case setCheckOut(Date)
    case search
}

public struct StayTypeSelectionOrganism: View {
    @Binding var props: StayTypeSelectionProps
    let send: (StayTypeSelectionAction) -> Void
    
    public init(
        props: Binding<StayTypeSelectionProps>,
        send: @escaping (StayTypeSelectionAction) -> Void
    ) {
        self._props = props;
        self.send = send
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            header
            if props.type == .hourly { hourly } else { nightly }
            APrimaryButton(
                title: "Search",
                height: 35,
                isFullWidth: true,
                font: .headline.weight(.bold),
                action: {
                    send(.search)
                }
            )
        }
    }
    
    private var header: some View {
        ASurface(bg: Color.blue.opacity(0.1), stroke: Color.blue.opacity(0.25)) {
            VStack(alignment: .leading, spacing: 8) {
                Picker("", selection: Binding(get: { props.type }, set: { props.type = $0; send(.setType($0)) })) {
                    ForEach(StayType.allCases) { Text($0.rawValue).tag($0) }
                }.pickerStyle(.segmented)
                Group {
                    if props.type == .hourly {
                        AText("BOOK FOR 3, 6 OR 9 HOURS!", style: .headline)
                        AText("Flexible slots, great savings", style: .subheadline, color: .secondary)
                    } else {
                        AText("BOOK FOR 1 OR MORE NIGHTS", style: .headline)
                        AText("Select your stay dates", style: .subheadline, color: .secondary)
                    }
                }
            }
        }
    }
    
    private var hourly: some View {
        VStack(alignment: .leading, spacing: 8) {
            MFieldCard { VStack(alignment: .leading, spacing: 6) { AText("City, Area or Property Name", style: .caption, color: .secondary); AText("Where to?", style: .headline) } }
            MFieldCard {
                VStack(alignment: .leading, spacing: 8) {
                    AText("Select Duration", style: .subheadline, color: .secondary)
                    HStack(spacing: 10) {
                        ForEach(props.hourOptions, id: \.self) { h in
                            AChip(.init(title: "\(h) Hours", selected: props.selectedHours == h)) { props.selectedHours = h; send(.setHours(h)) }
                        }
                    }
                }
            }
            MFieldCard {
                VStack(alignment: .leading, spacing: 8) {
                    DatePicker(
                        "Start Time",
                        selection: Binding(
                            get: { props.startTime },
                            set: { props.startTime = $0;
                                send(.setStartTime($0)
                                )
                            }
                        ),
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    
                    let end = Calendar.current.date(
                        byAdding: .hour,
                        value: props.selectedHours,
                        to: props.startTime
                    ) ?? props.startTime
                    
                    HStack {
                        AText("Ends", style: .body, color: .secondary);
                        Spacer();
                        Text(end.formatted(date: .abbreviated, time: .shortened)).font(.subheadline.weight(.semibold))
                    }
                }
            }
        }
    }
    
    private var nightly: some View {
        VStack(alignment: .leading, spacing: 8) {
            MFieldCard {
                VStack(alignment: .leading, spacing: 6) {
                    AText(
                        "City, Area or Property Name",
                        style: .caption,
                        color: .secondary
                    );
                    
                    AText("Where to?", style: .headline)
                }
            }
            
            HStack(spacing: 12) {
                MFieldCard {
                    VStack(alignment: .leading, spacing: 6) {
                        AText("Check-in", style: .caption, color: .secondary);
                        DatePicker(
                            "",
                            selection: Binding(
                                get: {
                                    props.checkIn
                                },set: {
                                    props.checkIn = $0;
                                    send(.setCheckIn($0))
                                }
                            ),
                            in: Date()..., displayedComponents: .date).labelsHidden()
                    }
                }
                
                MFieldCard {
                    VStack(alignment: .leading, spacing: 6) {
                        AText("Check-out", style: .caption, color: .secondary);
                        DatePicker(
                            "",
                            selection: Binding(
                                get: { props.checkOut },
                                set: { props.checkOut = $0;
                                    send(.setCheckOut($0))
                                }
                            ),
                            in: minCheckoutDate...,
                            displayedComponents: .date
                        ).labelsHidden()
                    }
                }
            }
            
            if props.checkOut <= props.checkIn {
                Text("Checkout must be after check-in.")
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
        }
    }
    
    private var minCheckoutDate: Date {
        Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: Calendar.current.startOfDay(for: props.checkIn)
        )!
    }
}
