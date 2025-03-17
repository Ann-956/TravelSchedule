import Foundation
import OpenAPIURLSession


    func stationsTrain() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = NearestStationsService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        Task {
            do {
                let request = NearestStationsServiceRequest(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 30,
                    stationTypes: "train_station",
                    transportTypes: "train"
                )
                let stations = try await service.getNearestStations(request: request)
                print("Станции:", stations)
            } catch {
                print("Ошибка при получении станций:", error)
            }
        }
    }

    func searchInfo() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = FlightsBetweenStationsService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: now)

        Task {
            do {
                let stationInfo = try await service.getFlightsBetweenStations(
                    from: "s9602494",
                    to: "s2006004",
                    date: currentDate
                )
                print("инфо", stationInfo)
            } catch {
                print("Ошибка при получении информации между станциями:", error)
            }
        }
    }

    func infoCarrier() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = InfoCarrierService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        Task {
            do {
                let infoCarrier = try await service.getInfoCarrier(
                    code: 129
                )
                print("инфо", infoCarrier)
            } catch {
                print("Ошибка при получении информации о перевозчике:", error)
            }
        }
    }

    func nearestSettlement() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = NearestSettlementService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        Task {
            do {
                let stations = try await service.getNearestSettlement(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 30
                )
                print("Город:", stations)
            } catch {
                print("Ошибка при получении станций:", error)
            }
        }
    }

    func scheduleByStation() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = ScheduleByStationService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: now)

        Task {
            do {
                let scheduleByStationInfo = try await service.getScheduleByStation(
                    station: "s9602494",
                    date: currentDate
                )
                print("инфо", scheduleByStationInfo)
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }

    func threadStations() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = ThreadStationsService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        Task {
            do {
                let threadStationsInfo = try await service.getThreadStations(
                    uid: "755A_0_2"
                )
                print("инфо", threadStationsInfo)
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }

    func stationList() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = StationListService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        Task {
            do {
                let stationListInfo = try await service.getStationList()
                print("инфо приходит")
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }

    func copyrightList() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = CopyrightService(
            client: client,
            apikey: Constants.yandexApiKey
        )

        Task {
            do {
                let copyrightInfo = try await service.getCopyrightYandex()
                print("инфо:", copyrightInfo)
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }

